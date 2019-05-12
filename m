From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 12 May 2019 11:58:19 -0700
Subject: [PATCH 5/6] nvme-cli: use uniform if .. else format
In-Reply-To: <20190512185820.20098-1-chaitanya.kulkarni@wdc.com>
References: <20190512185820.20098-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190512185820.20098-6-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme-models.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/nvme-models.c b/nvme-models.c
index 5006f7a..f90ab95 100644
--- a/nvme-models.c
+++ b/nvme-models.c
@@ -259,8 +259,7 @@ static FILE *open_pci_ids(void)
 	if ((pci_ids_path = getenv("PCI_IDS_PATH")) != NULL) {
 		if ((fp = fopen(pci_ids_path, "r")) != NULL) {
 			return fp;
-		}
-		else {
+		} else {
 			/* fail if user provided environment variable but could not open */
 			perror(pci_ids_path);
 			return NULL;
-- 
2.17.0
