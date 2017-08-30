From: daniel.verkamp@intel.com (Daniel Verkamp)
Date: Wed, 30 Aug 2017 15:25:16 -0700
Subject: [PATCH] nvme-cli: generate spec-compliant UUID NQNs
Message-ID: <20170830222516.44089-1-daniel.verkamp@intel.com>

The gen-hostnqn command previously generated UUID NQNs in a format that
does not match the NVMe specification.

Signed-off-by: Daniel Verkamp <daniel.verkamp at intel.com>
---
 Documentation/nvme-gen-hostnqn.txt | 2 +-
 nvme.c                             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/nvme-gen-hostnqn.txt b/Documentation/nvme-gen-hostnqn.txt
index 6d5346f..9efefb5 100644
--- a/Documentation/nvme-gen-hostnqn.txt
+++ b/Documentation/nvme-gen-hostnqn.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Generate a random host NQN in the form:
-nqn.2014-08.org.nvmexpress:NVMf:uuid:1b4e28ba-2fa1-11d2-883f-0016d3cca427
+nqn.2014-08.org.nvmexpress:uuid:1b4e28ba-2fa1-11d2-883f-0016d3cca427
 and prints it to stdout.
 
 OPTIONS
diff --git a/nvme.c b/nvme.c
index 676e8bf..f1d6d65 100644
--- a/nvme.c
+++ b/nvme.c
@@ -3217,7 +3217,7 @@ static int gen_hostnqn_cmd(int argc, char **argv, struct command *command, struc
 
 	uuid_generate_random(uuid);
 	uuid_unparse_lower(uuid, uuid_str);
-	printf("nqn.2014-08.org.nvmexpress:NVMf:uuid:%s\n", uuid_str);
+	printf("nqn.2014-08.org.nvmexpress:uuid:%s\n", uuid_str);
 	return 0;
 }
 #else
-- 
2.13.5
