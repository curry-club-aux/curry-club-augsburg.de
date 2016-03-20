theory Examples
imports Main
begin

theorem curry: "(A \<and> B \<longrightarrow> C) \<longrightarrow> (A \<longrightarrow> B \<longrightarrow> C)"
proof
  assume *: "A \<and> B \<longrightarrow> C"
  show "A \<longrightarrow> B \<longrightarrow> C"
  proof
    assume a: A
    show "B \<longrightarrow> C"
    proof
      assume b: B
      from a and b have "A \<and> B" ..
      with * show C ..
    qed
  qed
qed

theorem iff_contradiction:
  assumes *: "\<not> A \<longleftrightarrow> A"
  shows C
proof (rule notE)
  show "\<not> A"
  proof
    assume A
    with * have "\<not> A" ..
    from this and \<open>A\<close> show False ..
  qed
  with * show A ..
qed

theorem Cantor: "\<not> (\<exists>f :: 'a \<Rightarrow> 'a \<Rightarrow> bool. \<forall>A. \<exists>a. A = f a)"
proof
  assume "\<exists>f :: 'a \<Rightarrow> 'a \<Rightarrow> bool. \<forall>A. \<exists>a. A = f a"
  then obtain f :: "'a \<Rightarrow> 'a \<Rightarrow> bool" where *: "\<forall>A. \<exists>a. A = f a" ..
  let ?D = "\<lambda>x. \<not> f x x"
  from * have "\<exists>a. ?D = f a" ..
  then obtain a where "?D = f a" ..
  then have "?D a \<longleftrightarrow> f a a" using refl by (rule subst)
  then have "\<not> f a a \<longleftrightarrow> f a a" .
  then show False by (rule iff_contradiction)
qed

end