From: keith.busch@intel.com (Keith Busch)
Date: Thu, 25 Oct 2018 10:00:17 -0600
Subject: [PATCH 1/2] nvme-cli wdc plugin: Add get pfail dump command.
In-Reply-To: <SN1PR04MB19845135D5239B300018EFA0EAF70@SN1PR04MB1984.namprd04.prod.outlook.com>
References: <1539921985-17139-1-git-send-email-dong.ho@wdc.com>
 <20181019171713.GA25247@localhost.localdomain>
 <CAPrnrPAhfJmp48zNDgM3JYP2g0BbgAGDgdkB1OCotXHb_00FcQ@mail.gmail.com>
 <20181024162209.GA4461@localhost.localdomain>
 <CAPrnrPDdBinRXG_18ZBJp+FkFT3EWPDM4xC0vhgg+tOoiDJGcg@mail.gmail.com>
 <SN1PR04MB198440725CBB35D5EAAF94A4EAF60@SN1PR04MB1984.namprd04.prod.outlook.com>
 <20181024215137.GA5138@localhost.localdomain>
 <7A7D3AF3-13B1-4569-BAC0-3689E5304F4E@wdc.com>
 <SN1PR04MB19845135D5239B300018EFA0EAF70@SN1PR04MB1984.namprd04.prod.outlook.com>
Message-ID: <20181025160017.GA7035@localhost.localdomain>

On Thu, Oct 25, 2018@03:58:00PM +0000, Jeffrey Lien wrote:
> How does this look?   I've verified it on my Ubuntu system, but don't have a Fedora 28 system to verify the warning message has been resolved.
> 
> diff --git a/wdc-nvme.c b/wdc-nvme.c
> index 55b2889..db68d58 100644
> --- a/wdc-nvme.c
> +++ b/wdc-nvme.c
> @@ -1141,16 +1141,16 @@ static int wdc_do_crash_dump(int fd, char *file, int type)
>  static int wdc_crash_dump(int fd, char *file, int type)
>  {
>  	char f[PATH_MAX] = {0};
> -	char dump_type[PATH_MAX] = {0};
> +	char dump_type[12] = {0};
>  
>  	if (file != NULL) {
>  		strncpy(f, file, PATH_MAX - 1);
>  	}
>  
>  	if (type == WDC_NVME_PFAIL_DUMP_TYPE)
> -		strncpy(dump_type, "_pfail_dump", 11);
> +		strcpy(dump_type, "_pfail_dump");
>  	else
> -		strncpy(dump_type, "_crash_dump", 11);
> +		strcpy(dump_type, "_crash_dump");
>  
>  	if (wdc_get_serial_name(fd, f, PATH_MAX, dump_type) == -1) {
>  		fprintf(stderr, "ERROR : WDC : failed to generate file name\n");
> -- 

I just don't see the point in having multiple copies of the string. Why
not just use it directly?

---
diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index 8d61fa7..cd12edb 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -1141,16 +1141,16 @@ static int wdc_do_crash_dump(int fd, char *file, int type)
 static int wdc_crash_dump(int fd, char *file, int type)
 {
 	char f[PATH_MAX] = {0};
-	char dump_type[PATH_MAX] = {0};
+	char *dump_type;
 
 	if (file != NULL) {
 		strncpy(f, file, PATH_MAX - 1);
 	}
 
 	if (type == WDC_NVME_PFAIL_DUMP_TYPE)
-		strncpy(dump_type, "_pfail_dump", PATH_MAX - 1);
+		dump_type = "_pfail_dump";
 	else
-		strncpy(dump_type, "_crash_dump", PATH_MAX - 1);
+		dump_type = "_crash_dump";
 
 	if (wdc_get_serial_name(fd, f, PATH_MAX, dump_type) == -1) {
 		fprintf(stderr, "ERROR : WDC : failed to generate file name\n");
--
