From: Jeff.Lien@hgst.com (Jeffrey Lien)
Date: Wed, 14 Oct 2015 15:50:32 +0000
Subject: [PATCH] NVMe: Log Sense Temperature doesn't handle negative values
In-Reply-To: <BL2PR04MB163D243F18A279514DE4C1492310@BL2PR04MB163.namprd04.prod.outlook.com>
References: <BL2PR04MB1637F56809BDE2AC26E682C92350@BL2PR04MB163.namprd04.prod.outlook.com>
 <alpine.LNX.2.00.1510091945030.27742@localhost.lm.intel.com>
 <20151009201533.GA29975@localhost.localdomain>
 <20151009204108.GA30167@localhost.localdomain>
 <BL2PR04MB163D243F18A279514DE4C1492310@BL2PR04MB163.namprd04.prod.outlook.com>
Message-ID: <BL2PR04MB163949A29712B7F490C6A0E923F0@BL2PR04MB163.namprd04.prod.outlook.com>

Attached an updated patch with change Jon recommended below.   


-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Jeffrey Lien
Sent: Monday, October 12, 2015 3:25 PM
To: Jon Derrick <jonathan.derrick at intel.com>; Keith Busch <keith.busch at intel.com>
Cc: axboe at fb.com; David Darrington <david.darrington at hgst.com>; linux-nvme at lists.infradead.org
Subject: RE: [PATCH] NVMe: Log Sense Temperature doesn't handle negative values



-----Original Message-----
From: Jon Derrick [mailto:jonathan.derrick@intel.com]
Sent: Friday, October 9, 2015 3:41 PM
To: Keith Busch <keith.busch at intel.com>
Cc: Jeffrey Lien <Jeff.Lien at hgst.com>; axboe at fb.com; David Darrington <david.darrington at hgst.com>; linux-nvme at lists.infradead.org
Subject: Re: [PATCH] NVMe: Log Sense Temperature doesn't handle negative values

On Fri, Oct 09, 2015@02:15:33PM -0600, Jon Derrick wrote:
>> > >To meet the SCSI Command Spec (T10 SPC-4 r37), the log sense temperature cannot
>> > >be negative.   From the spec:
>> > >
>> > >The TEMPERATURE field indicates the temperature of the SCSI target 
>> > >device in degrees Celsius at the time the LOG SENSE command is 
>> > >performed. Temperatures equal to or less than zero degrees Celsius 
>> > >shall cause the TEMPERATURE field to be set to zero. If the device 
>> > >server is unable to detect a valid temperature because of a sensor 
>> > >failure or other condition, then the TEMPERATURE field shall be 
>> > >set to FFh. The temperature should be reported with an accuracy of 
>> > >plus or minus three Celsius degrees while the SCSI target device is operating at a steady state within its environmental limits.
>> > >
>> > >With the current code, a value of -2 C will be shown as 254 C 
>> > >since it was not written to handle negative vales.  This same 
>> > >issue also exists in nvme_trans_log_info_exceptions.
>> > 
>> > [snip]
>> > 
>> > >@@ -1097,7 +1101,7 @@ static int nvme_trans_log_temperature(struct nvme_ns *ns, struct sg_io_hdr *hdr,
>> > > 	dma_addr_t dma_addr;
>> > > 	void *mem;
>> > > 	u32 feature_resp;
>> > >-	u8 temp_c_cur, temp_c_thresh;
>> > >+	s8 temp_c_cur, temp_c_thresh;
>> > > 	u16 temp_k;
>> > > 	log_response = kzalloc(LOG_TEMP_PAGE_LENGTH, GFP_KERNEL); @@
>> > >-1129,6 +1133,10 @@ static int nvme_trans_log_temperature(struct nvme_ns *ns, struct sg_io_hdr *hdr,
>> > > 		temp_k = (smart_log->temperature[1] << 8) +
>> > > 				(smart_log->temperature[0]);
>> > > 		temp_c_cur = temp_k - KELVIN_TEMP_FACTOR;
>> > >+		/* if temp_c_cur is negative,          */
>> > >+		/* set to 0 to meet Scsi Command Spec  */
>> > >+		if (temp_c_cur < 0)
>> > >+			temp_c_cur = 0;
>> > 
>> > Interesting, < 0C is colder than I might have expected. What if 
>> > they can get hotter than expected, like 128C? I don't think we want 
>> > to report that as 0.
>> >
>> 
>> It's unfortunate the spec is written that way. Aerospace silicon is 
>> often rated for -55/-40C to +125C junction temp +/- a few %. Thats a 
>> big negative range missing if it has to be 0. I would imagine over 
>> 128C is not meaningful so we would want to report that as 128C
>> 

>Thinking about it again, I would much rather see the u8 being used so we get the full range.

>something like this should do:
>temp_c_cur = temp_k < KELVIN_TEMP_FACTOR ? 0 : temp_k - 
>KELVIN_TEMP_FACTOR;

I like that solution; simple and straight forward.   Want me to resubmit the patch with Jon's suggested change?
HGST E-mail Confidentiality Notice & Disclaimer:
This e-mail and any files transmitted with it may contain confidential or legally privileged information of HGST and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited.  If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-NVMe-Log-Sense-Temperature-doesn-t-handle-negative-v.patch
Type: application/octet-stream
Size: 2261 bytes
Desc: 0001-NVMe-Log-Sense-Temperature-doesn-t-handle-negative-v.patch
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20151014/5790a444/attachment.obj>
