From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Thu, 25 Oct 2018 17:28:25 +0000
Subject: [PATCH 1/2] nvme-cli wdc plugin: Add get pfail dump command.
References: <1539921985-17139-1-git-send-email-dong.ho@wdc.com>
 <20181019171713.GA25247@localhost.localdomain>
 <CAPrnrPAhfJmp48zNDgM3JYP2g0BbgAGDgdkB1OCotXHb_00FcQ@mail.gmail.com>
 <20181024162209.GA4461@localhost.localdomain>
 <CAPrnrPDdBinRXG_18ZBJp+FkFT3EWPDM4xC0vhgg+tOoiDJGcg@mail.gmail.com>
 <SN1PR04MB198440725CBB35D5EAAF94A4EAF60@SN1PR04MB1984.namprd04.prod.outlook.com>
 <20181024215137.GA5138@localhost.localdomain>
 <7A7D3AF3-13B1-4569-BAC0-3689E5304F4E@wdc.com>
 <SN1PR04MB19845135D5239B300018EFA0EAF70@SN1PR04MB1984.namprd04.prod.outlook.com>
 <20181025160017.GA7035@localhost.localdomain> 
Message-ID: <SN1PR04MB1984974B952F743367DC9FFCEAF70@SN1PR04MB1984.namprd04.prod.outlook.com>

Keith,
Ignore that last note.  I didn't scroll down far enough - my bad.   I'll fix up the patch the way Keith suggested.


Jeff Lien


-----Original Message-----
From: Jeffrey Lien 
Sent: Thursday, October 25, 2018 12:25 PM
To: 'Keith Busch' <keith.busch at intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni at wdc.com>; Eyal BenDavid <bdeyal at gmail.com>; Dong Ho <Dong.Ho at wdc.com>; linux-nvme <linux-nvme at lists.infradead.org>; Keith Busch <keith.busch at linux.intel.com>
Subject: RE: [PATCH 1/2] nvme-cli wdc plugin: Add get pfail dump command.

Keith, 
I'm not sure how to get away from 2 string copys other than having 2 calls to the wdc_get_serial_name function.  There are 2 potential dump types so I need to set dump_type to one or the other.   

Or are you suggesting setting  dump_type directly  like this:  

>  	if (type == WDC_NVME_PFAIL_DUMP_TYPE)
> -		strncpy(dump_type, "_pfail_dump", 11);
> +		dump_type = "_pfail_dump";
>  	else
> -		strncpy(dump_type, "_crash_dump", 11);
> +		dump_type = "_crash_dump";

Versus using strncpy?   

Jeff Lien


-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com]
Sent: Thursday, October 25, 2018 11:00 AM
To: Jeffrey Lien <Jeff.Lien at wdc.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni at wdc.com>; Eyal BenDavid <bdeyal at gmail.com>; Dong Ho <Dong.Ho at wdc.com>; linux-nvme <linux-nvme at lists.infradead.org>; Keith Busch <keith.busch at linux.intel.com>
Subject: Re: [PATCH 1/2] nvme-cli wdc plugin: Add get pfail dump command.

On Thu, Oct 25, 2018@03:58:00PM +0000, Jeffrey Lien wrote:
> How does this look?   I've verified it on my Ubuntu system, but don't have a Fedora 28 system to verify the warning message has been resolved.
> 
> diff --git a/wdc-nvme.c b/wdc-nvme.c
> index 55b2889..db68d58 100644
> --- a/wdc-nvme.c
> +++ b/wdc-nvme.c
> @@ -1141,16 +1141,16 @@ static int wdc_do_crash_dump(int fd, char 
> *file, int type)  static int wdc_crash_dump(int fd, char *file, int
> type)  {
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

I just don't see the point in having multiple copies of the string. Why not just use it directly?

---
diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c index 8d61fa7..cd12edb 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -1141,16 +1141,16 @@ static int wdc_do_crash_dump(int fd, char *file, int type)  static int wdc_crash_dump(int fd, char *file, int type)  {
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
