Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300C1C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jul 2022 14:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Mime-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hYDHjJgPJIKngUzhFpa2GcsaU6f17vDSPEXjebeVuMA=; b=RACB39Ak0xSm33mGcgW8IpMHIX
	AcrdZhF2VFRAHnjy2cibBZQLgRiTClZQ7GDFY6HWyGzo0LMwxmWyWdDqXVM749FIIw588kz+ILEh2
	8JjCWAhULqV5+f47mJAfA688zk67yAatzWPYWZ//SED6livTLZcu0e5fzIQ8X2b5BA7B9C0ZsOqCj
	u6GVqHsCGLHAVlbATog4v6GE+emp5dm1HIMRk3T8KVYKs0T/iHxGbDNFoJq8p4iuiH5rwaieJOF/W
	JM3ZEn9JpEe0ri9ko/9En4RIoBvxrOmg4iNo5JPVhD+637wQhf/P/7/wMzXb5yFEpoSInRRG4BFFT
	YOLzJEag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBGWP-00Bbpe-CB; Tue, 12 Jul 2022 14:05:53 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBGWL-00BboD-Lx
	for linux-nvme@lists.infradead.org; Tue, 12 Jul 2022 14:05:51 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CDmdxk004660;
	Tue, 12 Jul 2022 14:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=hYDHjJgPJIKngUzhFpa2GcsaU6f17vDSPEXjebeVuMA=;
 b=rqoXQafpUey82hwgODiN4q+sgDK8i6y6S3nrFSDYthrFQRB7pbIIrqysCklJIvd2KliS
 rI+4ZCRxR5zgvQHQfT+sQ7s2jDExKOCSUifRgmnePAyXASww1Ymx/6EyB/h42DK+pBQs
 anPg/N0w6fpVBSi1WThueAynP67NBftmOlDaKO3lgaqlxxhLdwcxPZ4/GLysmK91YnCL
 olIxoYQegb9iWbpsQkYETyRYeJvfHyIqpDpm5Yv6F7sgvySYbSx85uk/mqHNjYS/wx2W
 nBmhoc6G1wXTTRACKFG7u5U64fG7vfYlos5x595JEe2GIck37QD3/kV1pQ66Q3YkfafP 8Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9a5vrg08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Jul 2022 14:05:37 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26CDoL18029763;
	Tue, 12 Jul 2022 14:05:35 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma06ams.nl.ibm.com with ESMTP id 3h70xhv9qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Jul 2022 14:05:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26CE5WqR23659006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Jul 2022 14:05:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD30F4C044;
	Tue, 12 Jul 2022 14:05:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 591FA4C040;
	Tue, 12 Jul 2022 14:05:32 +0000 (GMT)
Received: from sig-9-145-145-217.de.ibm.com (unknown [9.145.145.217])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 12 Jul 2022 14:05:32 +0000 (GMT)
Message-ID: <99800ff42431d59a15401fdf33662581d9b7b563.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] nvme-pci: fix hang during error recovery when the
 PCI device is isolated
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Keith
 Busch <kbusch@kernel.org>
Cc: Stefan Roese <sr@denx.de>, Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 12 Jul 2022 16:05:31 +0200
In-Reply-To: <39098f08-696d-db4c-36ac-1199da95bc7c@suse.de>
References: <20220712124453.2227362-1-schnelle@linux.ibm.com>
	 <20220712124453.2227362-2-schnelle@linux.ibm.com>
	 <39098f08-696d-db4c-36ac-1199da95bc7c@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5sH9S8laB5taJYrMRdaOBDDCm56igysW
X-Proofpoint-GUID: 5sH9S8laB5taJYrMRdaOBDDCm56igysW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_08,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120055
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220712_070550_091075_66CCF8C8 
X-CRM114-Status: GOOD (  38.83  )
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

On Tue, 2022-07-12 at 15:49 +0200, Hannes Reinecke wrote:
> On 7/12/22 14:44, Niklas Schnelle wrote:
> > On s390 and powerpc PCI devices are isolated when an error is detected
> > and driver->err_handler->error_detected is called with an inaccessible
> > PCI device and PCI channel state set to pci_channel_io_frozen
> > (see Step 1 in Documentation/PCI/pci-error-recovery.rst).
> > 
> > In the case of NVMe devices nvme_error_detected() then calls
> > nvme_dev_disable(dev, false) and requests a reset. After a successful
> > reset the device is accessible again and nvme_slot_reset() resets the
> > controller and queues nvme_reset_work() which then recovers the
> > controller.
> > 
> > Since commit b98235d3a471 ("nvme-pci: harden drive presence detect in
> > nvme_dev_disable()") however nvme_dev_disable() no longer freezes the
> > queues if pci_device_is_present() returns false. This is the case for an
> > isolated PCI device. In principle this makes sense as there are no
> > accessible hardware queues to run. The problem though is that for
> > a previously live reset controller with online queues nvme_reset_work()
> > calls nvme_wait_freeze() which, without the freeze having been
> > initiated, then hangs forever. Fix this by starting the freeze in
> > nvme_slot_reset() which is the earliest point where we know the device
> > should be accessible again.
> > 
> > Fixes: b98235d3a471 ("nvme-pci: harden drive presence detect in nvme_dev_disable()")
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >   drivers/nvme/host/pci.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 193b44755662..7c0c61b74c30 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -3399,6 +3399,7 @@ static pci_ers_result_t nvme_slot_reset(struct pci_dev *pdev)
> >   	dev_info(dev->ctrl.device, "restart after slot reset\n");
> >   	pci_restore_state(pdev);
> >   	nvme_reset_ctrl(&dev->ctrl);
> > +	nvme_start_freeze(&dev->ctrl);
> >   	return PCI_ERS_RESULT_RECOVERED;
> >   }
> >   
> I am not sure if that's the right fix.
>  From your description the hang occurs as nvme_reset_ctrl() is calling 
> nvme_wait_freeze() without an corresponding nvme_start_freeze().
> So why are you calling it _after_ the call to nvme_reset_ctrl()?
> 
> Cheers,
> 
> Hannes

Hmm, the call chain that used to have the nvme_start_freeze()
is nvme_error_detected()->nvme_dev_disable()->nvme_start_freeze(). 

With the referenced commit that nvme_start_freeze() no longer happens
because the nvme_error_detected callback occurs before the reset when
the device is still inaccessible (as mentioned Step 1 in
Documentation/PCI/pci-error-recovery.rst).

There is indeed another nvme_dev_disable() call in nvme_reset_work()
but in the nvme_slot_reset() path this comes before
pci_enable_device_mem() was called so that also doesn't do the
nvme_start_freeze(). I also tried doing the nvme_start_freeze() there
but at least in my test that broke /sys/bus/pci/devices/<dev>/reset,
though not entirely sure why since nvme_start_freeze() looks like a no-
op when done a second time. I'm also not sure though what the right
approach is here though.


