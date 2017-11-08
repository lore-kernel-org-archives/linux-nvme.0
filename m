From: keith.busch@intel.com (Keith Busch)
Date: Wed, 8 Nov 2017 10:03:24 -0700
Subject: [PATCH 1/2] NVMe-CLI : WDC-Plugin Updated Smart Log Commands
In-Reply-To: <20171108164947.28987-1-jeff.lien@wdc.com>
References: <20171108164947.28987-1-jeff.lien@wdc.com>
Message-ID: <20171108170323.GB25017@localhost.localdomain>

On Wed, Nov 08, 2017@10:49:47AM -0600, jeffreyalien wrote:
>  PLUGIN(NAME("wdc", "Western Digital vendor specific extensions"),
>  	COMMAND_LIST(
> -		ENTRY("cap-diag", "WDC Capture-Diagnostics", wdc_cap_diag)
> -		ENTRY("drive-log", "WDC Drive Log", wdc_drive_log)
> -		ENTRY("get-crash-dump", "WDC Crash Dump", wdc_get_crash_dump)
> -		ENTRY("id-ctrl", "WDC identify controller", wdc_id_ctrl)
> -		ENTRY("purge", "WDC Purge", wdc_purge)
> -		ENTRY("purge-monitor", "WDC Purge Monitor", wdc_purge_monitor)
> -		ENTRY("smart-log-add", "WDC Additional Smart Log", wdc_smart_log_add)
> + 		ENTRY("cap-diag", "              WDC Capture-Diagnostics", wdc_cap_diag)
> + 		ENTRY("drive-log", "              WDC Drive Log", wdc_drive_log)
> + 		ENTRY("get-crash-dump", "              WDC Crash Dump", wdc_get_crash_dump)
> + 		ENTRY("id-ctrl", "              WDC identify controller", wdc_id_ctrl)
> + 		ENTRY("purge", "              WDC Purge", wdc_purge)
> + 		ENTRY("purge-monitor", "              WDC Purge Monitor", wdc_purge_monitor)
> + 		ENTRY("vs-smart-add-log", "             WDC Additional Smart Log", wdc_smart_add_log)
> + 		ENTRY("vs-smart-add-log-c1", "          WDC Additional Smart Log for C1 Log page", wdc_smart_add_log_c1)
>  	)
>  );

I wasn't sure why you added so much whitespace for your descriptions until
I ran it. Maybe drop the "vs-" prefix since it's already vendor-specific
by virtue of being a vendor specific plugin? The alignment comes out
nicer that way.
