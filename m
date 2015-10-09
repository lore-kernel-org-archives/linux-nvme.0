From: jonathan.derrick@intel.com (Jon Derrick)
Date: Fri, 9 Oct 2015 14:15:33 -0600
Subject: [PATCH] NVMe: Log Sense Temperature doesn't handle negative values
In-Reply-To: <alpine.LNX.2.00.1510091945030.27742@localhost.lm.intel.com>
References: <BL2PR04MB1637F56809BDE2AC26E682C92350@BL2PR04MB163.namprd04.prod.outlook.com>
 <alpine.LNX.2.00.1510091945030.27742@localhost.lm.intel.com>
Message-ID: <20151009201533.GA29975@localhost.localdomain>

> >To meet the SCSI Command Spec (T10 SPC-4 r37), the log sense temperature cannot
> >be negative.   From the spec:
> >
> >The TEMPERATURE field indicates the temperature of the SCSI target device in
> >degrees Celsius at the time the LOG SENSE command is performed. Temperatures
> >equal to or less than zero degrees Celsius shall cause the TEMPERATURE field
> >to be set to zero. If the device server is unable to detect a valid
> >temperature because of a sensor failure or other condition, then the
> >TEMPERATURE field shall be set to FFh. The temperature should be reported
> >with an accuracy of plus or minus three Celsius degrees while the SCSI target
> >device is operating at a steady state within its environmental limits.
> >
> >With the current code, a value of -2 C will be shown as 254 C since it was not
> >written to handle negative vales.  This same issue also exists in
> >nvme_trans_log_info_exceptions.
> 
> [snip]
> 
> >@@ -1097,7 +1101,7 @@ static int nvme_trans_log_temperature(struct nvme_ns *ns, struct sg_io_hdr *hdr,
> > 	dma_addr_t dma_addr;
> > 	void *mem;
> > 	u32 feature_resp;
> >-	u8 temp_c_cur, temp_c_thresh;
> >+	s8 temp_c_cur, temp_c_thresh;
> > 	u16 temp_k;
> > 	log_response = kzalloc(LOG_TEMP_PAGE_LENGTH, GFP_KERNEL);
> >@@ -1129,6 +1133,10 @@ static int nvme_trans_log_temperature(struct nvme_ns *ns, struct sg_io_hdr *hdr,
> > 		temp_k = (smart_log->temperature[1] << 8) +
> > 				(smart_log->temperature[0]);
> > 		temp_c_cur = temp_k - KELVIN_TEMP_FACTOR;
> >+		/* if temp_c_cur is negative,          */
> >+		/* set to 0 to meet Scsi Command Spec  */
> >+		if (temp_c_cur < 0)
> >+			temp_c_cur = 0;
> 
> Interesting, < 0C is colder than I might have expected. What if they
> can get hotter than expected, like 128C? I don't think we want to report
> that as 0.
>

It's unfortunate the spec is written that way. Aerospace silicon is often rated for -55/-40C to +125C junction temp +/- a few %. Thats a big negative range missing if it has to be 0. I would imagine over 128C is not meaningful so we would want to report that as 128C
