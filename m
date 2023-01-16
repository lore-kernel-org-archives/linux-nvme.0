Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEA2C46467
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jan 2023 21:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zz7xUNaUOA+l+ZZyJwyYTuUW1EHckj5QcLwaaQ4qAq0=; b=ZnUTaCUvkAhFHHHOFnLfp/HIHS
	7ZvpIm4Rlz+BL6kUY77few0KxCYBTwe5vpbKbCdgI2VpPg8DNo/hCVlM93tToaXdg26qca1zgXSu/
	kg5x4rTlZzSp6ZwZ8/dBugAKdXM2MOUziJMkqi/jzD/w+u45IAL24pJFpG3iu90HOnmyK/HZ1LL5W
	baxqQU0sSxxgJfx4NUZEReejJTm4X6GpVpqFQNfDxgHhiogjN0r+2TvS5NiYxZDbWJ+NOkalYhs14
	Z+5df0iGgKZeFYCcv5t4f9lQpKydLiqEE6GWgevr5uY/FLo2JzWMCZ/6+Flwg4MuCwirzuQmd+cwm
	AvAKY3xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHWoA-00C4m7-E7; Mon, 16 Jan 2023 21:14:22 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHWo6-00C4lG-IQ
	for linux-nvme@lists.infradead.org; Mon, 16 Jan 2023 21:14:21 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 3C4605C01E2;
	Mon, 16 Jan 2023 16:14:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 16 Jan 2023 16:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1673903652; x=1673990052; bh=zz
	7xUNaUOA+l+ZZyJwyYTuUW1EHckj5QcLwaaQ4qAq0=; b=l6jn/FTxo0MAFxBAkw
	zRLDdp6Yy11TuSYkMP0KAfA2YmEPMgCKJisVsnejW0aS34GuTm5oZuzmuj1Vv0dk
	7OKcm9V9W9uUcFUdHV4kh4ju8HanDrdvsnMuKYGPgx/+VhITAM9xw7Idopijxiab
	vqIQoH1R+tHp9zT5UZopK0c3dUNCIw2aYJ/TXvSHZDjokGLZc52bMv5zzshz/mLD
	/InOnNQug1boMJM62vZrb2ZZzmbcrInXsuVEEYnaZW5hvRzzlEGTQF6T+J8+n190
	TX8NHRlIesfvvByoV5hN8Bo8l8hSxO4Uc2tx7SNLcrW9/dpHg0ijYZNohScWJve3
	ErCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1673903652; x=1673990052; bh=zz7xUNaUOA+l+ZZyJwyYTuUW1EHc
	kj5QcLwaaQ4qAq0=; b=bGOCqEU3bmvo9lBygZ/UaTKt+MQuiX1JWkot9mvXJdBB
	5CGZTlw+C/slHR+IciXvGn6BnPvuEacsYz+XN6HlumJMT1rdho0/Enyl16hKlyN0
	h57MaBHKXtVlUSBG6Jxgl38JXM6byAV2zKD1L/cssxlmOVhA26WfnCLwrdHzWgAU
	JQIqpVzjWvVo9GhC5IsfwrSevC7tCA9PCsRM3G2kzn3JYjQvezfGnJybQlldXQ42
	SE9YGogefiFYEUpiglgLByCzNE5jYBVVx4bR9j9sc8pqm8U3oxGnvqM+ClPN/++j
	SiQLPoc3Q1BC+z+dgjntA+ORXwsBRUn7SkuN02aAhw==
X-ME-Sender: <xms:I77FYx47D863sf-x_wLVaN69fpJgRL2bOdngrr4FXmpAzy9VIweEbA>
    <xme:I77FY-47NzdDLSeRMtlVwZPDAal6bavdz5ineGc4gFvsZsf5405OhSa4K_ZOx2fUS
    xLqTCTtUrYgeTXQ2b4>
X-ME-Received: <xmr:I77FY4ewJL0ry6d23tTZM6qQUCw6POnzdSKvA_T8tAWoDjW6tD1bxXqoq7yQrnOT_S-AEIyorp1-gqMbh0Rj9-aIk1ZJdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtgedgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
    uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
    htthgvrhhnpeegheekudejuddvteeuueegledtieffveeuteejkeefiefgffefieeviedu
    leegtdenucffohhmrghinhepphgtihdrtgifnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:I77FY6Lfj5JNYe6iPltZf0HTLKoJqV5ndru5kUyxrCTH-99mFf3X2A>
    <xmx:I77FY1KIyYsj5TT0PQidnAlymxRBYxSCxs2EcaMe8meYScpQ-eiI5g>
    <xmx:I77FYzxTx92lR9IxU9XvOC0qactV-yGO3hJl1uSiHmVKK9_uJLWCNA>
    <xmx:JL7FY6qdv82udScOz8DK8HEiNxmsy-xdBUMx3QeeWkrDiLRiI9NtKQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jan 2023 16:14:09 -0500 (EST)
Date: Mon, 16 Jan 2023 22:14:07 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
Message-ID: <Y8W+H6T9DOZ08SoF@cormorant.local>
References: <Y8AG21o/9/3eUMIg@cormorant.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cc8lRwQTP8Gv0NvM"
Content-Disposition: inline
In-Reply-To: <Y8AG21o/9/3eUMIg@cormorant.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230116_131419_305333_8FE31435 
X-CRM114-Status: GOOD (  38.06  )
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


--cc8lRwQTP8Gv0NvM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 12 14:10, Klaus Jensen wrote:
> Hi all (linux-nvme, qemu-devel, maintainers),
>=20
> On QEMU riscv64, which does not use MSI/MSI-X and thus relies on
> pin-based interrupts, I'm seeing occasional completion timeouts, i.e.
>=20
>   nvme nvme0: I/O 333 QID 1 timeout, completion polled
>=20
> To rule out issues with shadow doorbells (which have been a source of
> frustration in the past), those are disabled. FWIW I'm also seeing the
> issue with shadow doorbells.
>=20
> 	diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> 	index f25cc2c235e9..28d8e7f4b56c 100644
> 	--- a/hw/nvme/ctrl.c
> 	+++ b/hw/nvme/ctrl.c
> 	@@ -7407,7 +7407,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice =
*pci_dev)
> 	     id->mdts =3D n->params.mdts;
> 	     id->ver =3D cpu_to_le32(NVME_SPEC_VER);
> 	     id->oacs =3D
> 	-        cpu_to_le16(NVME_OACS_NS_MGMT | NVME_OACS_FORMAT | NVME_OACS_DB=
BUF);
> 	+        cpu_to_le16(NVME_OACS_NS_MGMT | NVME_OACS_FORMAT);
> 	     id->cntrltype =3D 0x1;
>=20
> 	     /*
>=20
>=20
> I captured a trace from QEMU when this happens:
>=20
> pci_nvme_mmio_write addr 0x1008 data 0x4e size 4
> pci_nvme_mmio_doorbell_sq sqid 1 new_tail 78
> pci_nvme_io_cmd cid 4428 nsid 0x1 sqid 1 opc 0x2 opname 'NVME_NVM_CMD_REA=
D'
> pci_nvme_read cid 4428 nsid 1 nlb 32 count 16384 lba 0x1324
> pci_nvme_map_prp trans_len 4096 len 16384 prp1 0x80aca000 prp2 0x82474100=
 num_prps 5
> pci_nvme_map_addr addr 0x80aca000 len 4096
> pci_nvme_map_addr addr 0x80ac9000 len 4096
> pci_nvme_map_addr addr 0x80ac8000 len 4096
> pci_nvme_map_addr addr 0x80ac7000 len 4096
> pci_nvme_io_cmd cid 4429 nsid 0x1 sqid 1 opc 0x2 opname 'NVME_NVM_CMD_REA=
D'
> pci_nvme_read cid 4429 nsid 1 nlb 224 count 114688 lba 0x1242
> pci_nvme_map_prp trans_len 4096 len 114688 prp1 0x80ae6000 prp2 0x8247400=
0 num_prps 29
> pci_nvme_map_addr addr 0x80ae6000 len 4096
> pci_nvme_map_addr addr 0x80ae5000 len 4096
> pci_nvme_map_addr addr 0x80ae4000 len 4096
> pci_nvme_map_addr addr 0x80ae3000 len 4096
> pci_nvme_map_addr addr 0x80ae2000 len 4096
> pci_nvme_map_addr addr 0x80ae1000 len 4096
> pci_nvme_map_addr addr 0x80ae0000 len 4096
> pci_nvme_map_addr addr 0x80adf000 len 4096
> pci_nvme_map_addr addr 0x80ade000 len 4096
> pci_nvme_map_addr addr 0x80add000 len 4096
> pci_nvme_map_addr addr 0x80adc000 len 4096
> pci_nvme_map_addr addr 0x80adb000 len 4096
> pci_nvme_map_addr addr 0x80ada000 len 4096
> pci_nvme_map_addr addr 0x80ad9000 len 4096
> pci_nvme_map_addr addr 0x80ad8000 len 4096
> pci_nvme_map_addr addr 0x80ad7000 len 4096
> pci_nvme_map_addr addr 0x80ad6000 len 4096
> pci_nvme_map_addr addr 0x80ad5000 len 4096
> pci_nvme_map_addr addr 0x80ad4000 len 4096
> pci_nvme_map_addr addr 0x80ad3000 len 4096
> pci_nvme_map_addr addr 0x80ad2000 len 4096
> pci_nvme_map_addr addr 0x80ad1000 len 4096
> pci_nvme_map_addr addr 0x80ad0000 len 4096
> pci_nvme_map_addr addr 0x80acf000 len 4096
> pci_nvme_map_addr addr 0x80ace000 len 4096
> pci_nvme_map_addr addr 0x80acd000 len 4096
> pci_nvme_map_addr addr 0x80acc000 len 4096
> pci_nvme_map_addr addr 0x80acb000 len 4096
> pci_nvme_rw_cb cid 4428 blk 'd0'
> pci_nvme_rw_complete_cb cid 4428 blk 'd0'
> pci_nvme_enqueue_req_completion cid 4428 cqid 1 dw0 0x0 dw1 0x0 status 0x0
> [1]: pci_nvme_irq_pin pulsing IRQ pin
> pci_nvme_rw_cb cid 4429 blk 'd0'
> pci_nvme_rw_complete_cb cid 4429 blk 'd0'
> pci_nvme_enqueue_req_completion cid 4429 cqid 1 dw0 0x0 dw1 0x0 status 0x0
> [2]: pci_nvme_irq_pin pulsing IRQ pin
> [3]: pci_nvme_mmio_write addr 0x100c data 0x4d size 4
> [4]: pci_nvme_mmio_doorbell_cq cqid 1 new_head 77
> ---- TIMEOUT HERE (30s) ---
> [5]: pci_nvme_mmio_read addr 0x1c size 4
> [6]: pci_nvme_mmio_write addr 0x100c data 0x4e size 4
> [7]: pci_nvme_mmio_doorbell_cq cqid 1 new_head 78
> --- Interrupt deasserted (cq->tail =3D=3D cq->head)
> [   31.757821] nvme nvme0: I/O 333 QID 1 timeout, completion polled
>=20
> Following the timeout, everything returns to "normal" and device/driver
> happily continues.
>=20
> The pin-based interrupt logic in hw/nvme seems sound enough to me, so I
> am wondering if there is something going on with the kernel driver (but
> I certainly do not rule out that hw/nvme is at fault here, since
> pin-based interrupts has also been a source of several issues in the
> past).
>=20
> What I'm thinking is that following the interrupt in [1], the driver
> picks up completion for cid 4428 but does not find cid 4429 in the queue
> since it has not been posted yet. Before getting a cq head doorbell
> write (which would cause the pin to be deasserted), the device posts the
> completion for cid 4429 which just keeps the interrupt asserted in [2].
> The trace then shows the cq head doorbell update in [3,4] for cid 4428
> and then we hit the timeout since the driver is not aware that cid 4429
> has been posted in between this (why is it not aware of this?) Timing
> out, the driver then polls the queue and notices cid 4429 and updates
> the cq head doorbell in [5-7], causing the device to deassert the
> interrupt and we are "back in shape".
>=20
> I'm observing this on 6.0 kernels and v6.2-rc3 (have not tested <6.0).
> Tested on QEMU v7.0.0 (to rule out all the shadow doorbell
> optimizations) as well as QEMU nvme-next (infradead). In other words,
> it's not a recent regression in either project and potentially it has
> always been like this. I've not tested other platforms for now, but I
> would assume others using pin-based interrupts would observe the same.
>=20
> Any ideas on how to shed any light on this issue from the kernel side of
> things?

I noticed that the Linux driver does not use the INTMS/INTMC registers
to mask interrupts on the controller while processing CQEs. While not
required by the spec, it is *recommended* in setups not using MSI-X to
reduce the risk of spurious and/or missed interrupts.

With the patch below, running 100 boot iterations, no timeouts were
observed on QEMU emulated riscv64 or mips64.

No changes are required in the QEMU hw/nvme interrupt logic.


diff --git i/drivers/nvme/host/pci.c w/drivers/nvme/host/pci.c
index b13baccedb4a..75f6b87c4c3f 100644
--- i/drivers/nvme/host/pci.c
+++ w/drivers/nvme/host/pci.c
@@ -1128,6 +1128,27 @@ static inline int nvme_poll_cq(struct nvme_queue *nv=
meq,
 }

 static irqreturn_t nvme_irq(int irq, void *data)
+{
+       struct nvme_queue *nvmeq =3D data;
+       struct nvme_dev *dev =3D nvmeq->dev;
+       u32 mask =3D 1 << nvmeq->cq_vector;
+       irqreturn_t ret =3D IRQ_NONE;
+       DEFINE_IO_COMP_BATCH(iob);
+
+       writel(mask, dev->bar + NVME_REG_INTMS);
+
+       if (nvme_poll_cq(nvmeq, &iob)) {
+               if (!rq_list_empty(iob.req_list))
+                       nvme_pci_complete_batch(&iob);
+               ret =3D IRQ_HANDLED;
+       }
+
+       writel(mask, dev->bar + NVME_REG_INTMC);
+
+       return ret;
+}
+
+static irqreturn_t nvme_irq_msix(int irq, void *data)
 {
        struct nvme_queue *nvmeq =3D data;
        DEFINE_IO_COMP_BATCH(iob);
@@ -1602,12 +1623,13 @@ static int queue_request_irq(struct nvme_queue *nvm=
eq)
 {
        struct pci_dev *pdev =3D to_pci_dev(nvmeq->dev->dev);
        int nr =3D nvmeq->dev->ctrl.instance;
+       irq_handler_t handler =3D pdev->msix_enabled ? nvme_irq_msix : nvme=
_irq;

        if (use_threaded_interrupts) {
                return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_che=
ck,
-                               nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qi=
d);
+                               handler, nvmeq, "nvme%dq%d", nr, nvmeq->qid=
);
        } else {
-               return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
+               return pci_request_irq(pdev, nvmeq->cq_vector, handler,
                                NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
        }
 }



--cc8lRwQTP8Gv0NvM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmPFvh4ACgkQTeGvMW1P
DekT9wf/ei/LqtKzzs/EITjBAVKU0HG1j55VBgy5hIS8xF/DkJ+xSPBUz+2rzcjF
XdtvTVdmsFnzJjiccCtgTdc5TiiUWxODjtlepVlI4V78EBsW4NPRcNCwZ9cHCHf2
6axD15A6sBVkkTz6SUCzHw6TQ3+QIvghtM2wD2AyKXINlJdmI/QhKDx7hNId9drP
XyV0Mo/TdWokjRyaoeUoLEkAYFKp+WURaXvdTgsg/U8vgLAMJU3jxfRz9nQvYa3Q
N/hXLT+zbfCi7bmsDwl6C1Z5ty4Sa8GcXc5MzAQmKHcQtEk3QVnn8aCBF2CMQWxZ
LHUddsiWcVfnIkwVwvT3fIYlvWSOyg==
=yZaH
-----END PGP SIGNATURE-----

--cc8lRwQTP8Gv0NvM--

