Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F3DC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Apr 2022 07:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:Cc:From:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jw4Ugr+EWi38ciYAYqmuxrXI+RRrTISYEUvObmMAiII=; b=bT+shg7DIZg0CxI6gY/Po3PsfX
	OIsnwjjTKlZPqvryFWHkIbbuNAdJqUcppA+rS8cMWmNyzM7Qj74h+Nus3M9SmMj1Jbv8j6E1P7r2Y
	NQRXObE4MzoKDYFrW8ybN5BnFRtJvIxspBLFiGLrXvll/iCN7EPR7+onwLDrx2dEEzxC8PeR1/DV1
	wxz4+Ky1Mk4q5ipsB3J/KgAY38u/d/HUrZp4AwbmWX+BpSX0yGxjGe2oi91g8dKh734NhrdBxOhpL
	AgKRvoKncOP/mHZyPhMxkiAPJNx/qnmOMm5xyme7WCAqTZ2qVbE8knbnGl4a3QF4r4888Fx9plZ3J
	c7GJurog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1naC7z-004qJB-Q0; Fri, 01 Apr 2022 07:55:27 +0000
Received: from wp530.webpack.hosteurope.de ([2a01:488:42:1000:50ed:8234::])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1naC7v-004qGd-J2
 for linux-nvme@lists.infradead.org; Fri, 01 Apr 2022 07:55:26 +0000
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149]
 helo=[192.168.66.200]); authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1naC7n-0007Qi-Ct; Fri, 01 Apr 2022 09:55:15 +0200
Message-ID: <edba451c-1798-c60e-5d84-0a9f6a5d134d@leemhuis.info>
Date: Fri, 1 Apr 2022 09:55:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
From: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Jian-Hong Pan <jhp@endlessos.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Bug 215742 - The NVME storage quirked as SIMPLE SUSPEND makes system
 resume failed after suspend (Regression)
To: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1648799723;
 b14f6c75; 
X-HE-SMSGID: 1naC7n-0007Qi-Ct
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220401_005523_817327_5A79F042 
X-CRM114-Status: GOOD (  33.72  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi, this is your Linux kernel regression tracker.

I noticed a regression report in bugzilla.kernel.org that afaics nobody
acted upon since it was reported about a week ago, that's why I decided
to forward it to the lists and all people that seemed to be relevant
here. Mario, could you maybe take a look at this? Or is that something
for the NVM or ACPI people? Or was this discussed somewhere else
already? Or even fixed?

To quote from https://bugzilla.kernel.org/show_bug.cgi?id=215742 :

>  Jian-Hong Pan 2022-03-25 06:41:53 UTC
> 
> Created attachment 300614 [details]
> Journal log
> 
> We have an ASUS B1400CEAE laptop equipped with Intel i5-1135G7 and Sandisk Corp WD Blue SN550 NVMe SSD.  The system can resume from suspend correctly with kernel 5.10.  However, it resumes failed from suspend and hangs with kernel 5.15 and current 5.17, which is a regression issue.
> 
> I set the persistent journal log.  I read the journal log again and again. I notice there is nothing after system becomes suspended.  The kernel messages after resume might write failed to NVMe.
> 
> Then, I notice the message "kernel: nvme 0000:01:00.0: platform quirk: setting simple suspend".  Wonder why it quirks as simple suspend.  Trace the code and disable the quirk, like
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 9f4f3884fefe..017a87ae999f 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3096,7 +3096,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>                  */
>                 dev_info(&pdev->dev,
>                          "platform quirk: setting simple suspend\n");
> -               quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
> +               //quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
>         }
>  
>         /*
> 
> System resumes successfully!!!  NVMe is the one which produces the bug!
> 
> [reply] [−] Comment 1 Jian-Hong Pan 2022-03-25 06:45:48 UTC
> 
> Here is the information of the NVMe:
> 
> 01:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> 	Subsystem: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009]
> 	Flags: bus master, fast devsel, latency 0, IRQ 16, NUMA node 0, IOMMU group 14
> 	Memory at 82200000 (64-bit, non-prefetchable) [size=16K]
> 	Memory at 82204000 (64-bit, non-prefetchable) [size=256]
> 	Capabilities: [80] Power Management version 3
> 	Capabilities: [90] MSI: Enable- Count=1/32 Maskable- 64bit+
> 	Capabilities: [b0] MSI-X: Enable+ Count=17 Masked-
> 	Capabilities: [c0] Express Endpoint, MSI 00
> 	Capabilities: [100] Advanced Error Reporting
> 	Capabilities: [150] Device Serial Number 00-00-00-00-00-00-00-00
> 	Capabilities: [1b8] Latency Tolerance Reporting
> 	Capabilities: [300] Secondary PCI Express
> 	Capabilities: [900] L1 PM Substates
> 	Kernel driver in use: nvme
> 
> [reply] [−] Comment 2 Jian-Hong Pan 2022-03-25 07:01:26 UTC
> 
> Created attachment 300615 [details]
> Dump ACPI
> 
> To understand why it needs the simple suspend quirk, I trace acpi_storage_d3() [1] in the if condition.
> 
> I notice it goes though the whole acpi_storage_d3(), which means the ACPI node has StorageD3Enable with value 1.
> 
> To confrim that, I dumped the ACPI and found it:
> 
> Scope (_SB.PC00)
> {
>     Device (SAT0)
>     {
>         Name (_ADR, 0x00170000)  // _ADR: Address
>         Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
>         {
>             ToUUID ("5025030f-842f-4ab4-a561-99a5189762d0") /* Unknown UUID */, 
>             Package (0x01)
>             {
>                 Package (0x02)
>                 {
>                     "StorageD3Enable", 
>                     One
>                 }
>             }
>         })
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/device_pm.c?h=v5.17#n1381
> 
> [reply] [−] Comment 3 Jian-Hong Pan 2022-03-25 07:10:25 UTC
> 
> I found three related commits:
> 
> * df4f9bc4fb9c ("nvme-pci: add support for ACPI StorageD3Enable property")
> * e21e0243e7b0 ("nvme-pci: look for StorageD3Enable on companion ACPI device instead")
> * 2744d7a07335 ("ACPI: Check StorageD3Enable _DSD property in ACPI code")
> 
> The original ACPI node PXSX and PEGP check is removed in e21e0243e7b0 ("nvme-pci: look for StorageD3Enable on companion ACPI device instead") for AMD platforms.
> I did not see the ACPI node PXSX, nor PEGP in the ACPI tables in comment #2.
> 
> So, I add the check back for test:
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index cc6c97e7dcae..d5d93d3f01f7 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1381,6 +1381,8 @@ EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
>  bool acpi_storage_d3(struct device *dev)
>  {
>         struct acpi_device *adev = ACPI_COMPANION(dev);
> +       acpi_handle handle;
> +       acpi_status status;
>         u8 val;
>  
>         if (force_storage_d3())
> @@ -1388,6 +1390,14 @@ bool acpi_storage_d3(struct device *dev)
>  
>         if (!adev)
>                 return false;
> +
> +       status = acpi_get_handle(adev->handle, "PXSX", &handle);
> +       if (ACPI_FAILURE(status)) {
> +               status = acpi_get_handle(adev->handle, "PEGP", &handle);
> +               if (ACPI_FAILURE(status))
> +                       return false;
> +       }
> +
>         if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
>                         &val))
>                 return false;
> 
> System resumes successfully! I think Intel platforms need the check provided by df4f9bc4fb9c ("nvme-pci: add support for ACPI StorageD3Enable property").
> 
> [reply] [−] Comment 4 Jian-Hong Pan 2022-03-25 07:28:12 UTC
> 
> With the test patch in comment #3, the NVMe will not be quirked as NVME_QUIRK_SIMPLE_SUSPEND.  And then, system can resume from suspend correctly.
> 
> However, does this mean that the NVMe on this laptop does not support simple suspend?
> 
> [reply] [−] Comment 5 Jian-Hong Pan 2022-03-25 08:15:16 UTC
> 
> If I set test modes of hibernation for PM test [1]:
> 
> * devices mode: System resumes correctly
> 
> # echo devices > /sys/power/pm_test
> # echo platform > /sys/power/disk
> # echo mem > /sys/power/state
> 
> * platform mode: System resumes failed
> 
> # echo platform > /sys/power/pm_test
> # echo platform > /sys/power/disk
> # echo mem > /sys/power/state
> 
> [1] https://www.kernel.org/doc/Documentation/power/basic-pm-debugging.txt
> 
Anyway, to get this tracked:

#regzbot introduced: e21e0243e7b0
#regzbot from: Jian-Hong Pan <jhp@endlessos.org>
#regzbot title: nvm|acpi: NVME storage quirked as SIMPLE SUSPEND makes
system resume failed after suspend (Regression)
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215742

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

-- 
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
CC the regression list and tell regzbot about the issue, as that ensures
the regression makes it onto the radar of the Linux kernel's regression
tracker -- that's in your interest, as it ensures your report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include 'Link:' tag in the patch descriptions pointing to all reports
about the issue. This has been expected from developers even before
regzbot showed up for reasons explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'.

