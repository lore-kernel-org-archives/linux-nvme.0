From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Thu, 25 Oct 2018 15:58:00 +0000
Subject: [PATCH 1/2] nvme-cli wdc plugin: Add get pfail dump command.
In-Reply-To: <7A7D3AF3-13B1-4569-BAC0-3689E5304F4E@wdc.com>
References: <1539921985-17139-1-git-send-email-dong.ho@wdc.com>
 <20181019171713.GA25247@localhost.localdomain>
 <CAPrnrPAhfJmp48zNDgM3JYP2g0BbgAGDgdkB1OCotXHb_00FcQ@mail.gmail.com>
 <20181024162209.GA4461@localhost.localdomain>
 <CAPrnrPDdBinRXG_18ZBJp+FkFT3EWPDM4xC0vhgg+tOoiDJGcg@mail.gmail.com>
 <SN1PR04MB198440725CBB35D5EAAF94A4EAF60@SN1PR04MB1984.namprd04.prod.outlook.com>
 <20181024215137.GA5138@localhost.localdomain>
 <7A7D3AF3-13B1-4569-BAC0-3689E5304F4E@wdc.com>
Message-ID: <SN1PR04MB19845135D5239B300018EFA0EAF70@SN1PR04MB1984.namprd04.prod.outlook.com>

How does this look?   I've verified it on my Ubuntu system, but don't have a Fedora 28 system to verify the warning message has been resolved.

diff --git a/wdc-nvme.c b/wdc-nvme.c
index 55b2889..db68d58 100644
--- a/wdc-nvme.c
+++ b/wdc-nvme.c
@@ -1141,16 +1141,16 @@ static int wdc_do_crash_dump(int fd, char *file, int type)
 static int wdc_crash_dump(int fd, char *file, int type)
 {
 	char f[PATH_MAX] = {0};
-	char dump_type[PATH_MAX] = {0};
+	char dump_type[12] = {0};
 
 	if (file != NULL) {
 		strncpy(f, file, PATH_MAX - 1);
 	}
 
 	if (type == WDC_NVME_PFAIL_DUMP_TYPE)
-		strncpy(dump_type, "_pfail_dump", 11);
+		strcpy(dump_type, "_pfail_dump");
 	else
-		strncpy(dump_type, "_crash_dump", 11);
+		strcpy(dump_type, "_crash_dump");
 
 	if (wdc_get_serial_name(fd, f, PATH_MAX, dump_type) == -1) {
 		fprintf(stderr, "ERROR : WDC : failed to generate file name\n");
-- 
1.8.3.1


Jeff Lien


-----Original Message-----
From: Chaitanya Kulkarni 
Sent: Wednesday, October 24, 2018 5:20 PM
To: Keith Busch <keith.busch at intel.com>; Jeffrey Lien <Jeff.Lien at wdc.com>
Cc: Eyal BenDavid <bdeyal at gmail.com>; Dong Ho <Dong.Ho at wdc.com>; linux-nvme <linux-nvme at lists.infradead.org>; Keith Busch <keith.busch at linux.intel.com>
Subject: Re: [PATCH 1/2] nvme-cli wdc plugin: Add get pfail dump command.

Hi Jeff,

-static int wdc_crash_dump(int fd, char *file)
+static int wdc_crash_dump(int fd, char *file, int type)
 {
        char f[PATH_MAX] = {0};
+       char dump_type[PATH_MAX] = {0};

Please follow the Keith's comment, "dump_type" should not use the PATH_MAX as this predefined macro is used to hold the pathname for the file, so we need to change the dump_type.

Either allocate a memory for dump_type or defined a macro as it is suffix we don't have to copy string literal.

?On 10/24/18, 2:54 PM, "Linux-nvme on behalf of Keith Busch" <linux-nvme-bounces@lists.infradead.org on behalf of keith.busch@intel.com> wrote:

    On Wed, Oct 24, 2018@09:42:28PM +0000, Jeffrey Lien wrote:
    > Yea, the intent is to copy 11 bytes into the string.  The zero byte/space is not needed so memcpy is probably the better solution.  
    
    No, look again. The string terminator most certainly is needed the way
    you're using it. It happened to work out since you've initialized the
    temporary character array to all 0's, but there was no reason to even
    allocate 4k stack space to hold a copy of that string instead of using
    the pointing a 'const char *' directly to the literal.
    
    _______________________________________________
    Linux-nvme mailing list
    Linux-nvme at lists.infradead.org
    http://lists.infradead.org/mailman/listinfo/linux-nvme
    
