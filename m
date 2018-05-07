From: willy@infradead.org (Matthew Wilcox)
Date: Mon, 7 May 2018 06:43:54 -0700
Subject: PCIe unsupported request with Intel 760p
In-Reply-To: <20180507123035.GA20097@gmail.com>
References: <CAKDfzeD5_AV=YtWqTPr=40vvW4oMFAs4gJs_r42PJWcb815zyQ@mail.gmail.com>
 <20180507123035.GA20097@gmail.com>
Message-ID: <20180507134354.GF18116@bombadil.infradead.org>

On Mon, May 07, 2018@08:30:35AM -0400, Aron Griffis wrote:
> I'm getting this error continuously with an Intel 760p on 4.16.5 (Fedora 28)
> 
> pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: id=00e8
> pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=00e8(Requester ID)
> pcieport 0000:00:1d.0:   device [8086:a298] error status/mask=00100000/00010000
> pcieport 0000:00:1d.0:    [20] Unsupported Request    (First)
> pcieport 0000:00:1d.0:   TLP Header: 34000000 70000010 00000000 88468846
> pcieport 0000:00:1d.0: broadcast error_detected message
> pcieport 0000:00:1d.0: broadcast mmio_enabled message
> pcieport 0000:00:1d.0: broadcast resume message
> pcieport 0000:00:1d.0: AER: Device recovery successful
> 
> Willy graciously decoded this for me to a "Latency Tolerance Reporting
> Message," and suggested I send email to this list to check whether it's a
> problem with the device or driver.

Decoding this further, the Requester ID is 70:00.0 (ie the NVMe device is
sending the LTR message) so the Root Port is the one saying "Unsupported
Request".  Which is fair enough, because ...

> 00:1d.0 PCI bridge: Intel Corporation 200 Series PCH PCI Express Root Port #9 (rev f0) (prog-if 00 [Normal decode])
> 	Bus: primary=00, secondary=70, subordinate=70, sec-latency=0
> 		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd+
> 			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
> 			 AtomicOpsCtl: ReqEn- EgressBlck-

the Root Port doesn't know what LTR is.

> 70:00.0 Non-Volatile memory controller: Intel Corporation Device f1a6 (rev 03) (prog-if 02 [NVM Express])
> 	Capabilities: [70] Express (v2) Endpoint, MSI 00
> 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Not Supported
> 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
> 			 AtomicOpsCtl: ReqEn-

The device *does* know what LTR is, but it's supposed to be disabled.

Is there more recent firmware for this device?
