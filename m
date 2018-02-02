From: keith.busch@intel.com (Keith Busch)
Date: Fri, 2 Feb 2018 16:18:58 -0700
Subject: [PATCH] NVMe-CLI Fix fw_log Command json output
In-Reply-To: <20180202211058.9592-1-jeff.lien@wdc.com>
References: <20180202211058.9592-1-jeff.lien@wdc.com>
Message-ID: <20180202231858.GM24417@localhost.localdomain>

On Fri, Feb 02, 2018@03:10:58PM -0600, Jeff Lien wrote:
> Currently, the json output for the fw_log command slot number
> is zero based while the normal output is one based.  This patch
> will change the json output to one based.  It will also only
> print the revisions for the valid slots.

Totally fine with the json update. Not sure about the binary output,
though. That mode is meant for piping structures to other programs and not
sure how those will handle data beyond what they're expecting.

 
> @@ -58,6 +58,7 @@ void d_raw(unsigned char *buf, unsigned len)
>  	unsigned i;
>  	for (i = 0; i < len; i++)
>  		putchar(*(buf+i));
> +	printf("\n");
>  }
>  
>  static void format(char *formatter, size_t fmt_sz, char *tofmt, size_t tofmtsz)
> @@ -1928,10 +1929,12 @@ void json_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname)
>  	json_object_add_value_int(fwsi, "Active Firmware Slot (afi)", fw_log->afi);
>  
>  	for (i = 0; i < 7; i++) {
> -		snprintf(fmt, sizeof(fmt), "Firmware Rev Slot %d", i);
> -		snprintf(str, sizeof(str), "%"PRIu64" (%s)", (uint64_t)fw_log->frs[i],
> -			 fw_to_string(fw_log->frs[i]));
> -		json_object_add_value_string(fwsi, fmt, str);
> +		if (fw_log->frs[i]) {
> +		 	snprintf(fmt, sizeof(fmt), "Firmware Rev Slot %d", i+1);
> +		 	snprintf(str, sizeof(str), "%"PRIu64" (%s)", (uint64_t)fw_log->frs[i],
> +		 		fw_to_string(fw_log->frs[i]));
> +		 	json_object_add_value_string(fwsi, fmt, str);
> +		 }
>  	}
>  	json_object_add_value_object(root, devname, fwsi);
