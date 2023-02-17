Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49D2C636D4
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Feb 2023 13:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eq+vd5/u0vTPMlp0b3NDUReHDOice7k20Mvpv6BKlCM=; b=H2hbIDdA62sVQD2yjJSLVTHn+W
	3A1s7pFqRBfcJOLEhIVSik1Neq+mcevIdyT56fZFgdP45+x7uXBHmDHsGBS6kSxDR0UXH/2EmrjFS
	vuxYeoEtzAgOoaKlnRsnIw0t5fAu25wCd8xnp0YYlwnt308JURysKKIHxq0A2RJ/np/O5fSywPd//
	t2WSfdkYl9joM46XnXdxDIZjFhPDcVXRdqHG0MluuO8cvm3ARkwRHpTpMXySX2wHZle2eGKU5rDAP
	08OZOuZSLuH/lRksx1y2i1v1dxBoFtqTyoVwAIKL+Ksk65+AZkbsb3PN69gGf5wxFqCmxa65n/LHc
	a0rRx4Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT0n4-00EHz9-7M; Fri, 17 Feb 2023 13:28:42 +0000
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT0n1-00EHyC-Kb
	for linux-nvme@lists.infradead.org; Fri, 17 Feb 2023 13:28:41 +0000
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-535a11239faso24692887b3.13
        for <linux-nvme@lists.infradead.org>; Fri, 17 Feb 2023 05:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eq+vd5/u0vTPMlp0b3NDUReHDOice7k20Mvpv6BKlCM=;
        b=N1ATPKTsPkxU4bDMpbeYttTgSpaLiE7A0J/zCMsTT50RaO3NiO098ibH8fXAHL8A8p
         e2dqyLVp3ELa7WawK1KHQE7wpooFp7AjfgTelE2udkstcVhnO7VivpI/LdNGt6PCRuwJ
         5OKxmUbE8pUxloAqZRtDUrnGb9hrn0Wkj/5GYS6QOid1akwPSljRlqKtwgqkZ3ZABHww
         o6K1LIEMbLK1EAn8Yn57tg2jq3/IDPXko9DNsiWpRWCZ9HRzxsa6UPQO29tqBPCJSaTW
         hL92ku3F4VU7AHSJcAjLrIFziywe0ZVxtXnxlhHKKYdk9OHBZ0wWQmQNcCdviowsaNF0
         bpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eq+vd5/u0vTPMlp0b3NDUReHDOice7k20Mvpv6BKlCM=;
        b=Hd/kSLAz6Q+k1zlCd86y/cHtzVNsYZu/Nj+BSCGmXya7F5AnRp7xVPe2a5I4TD3SCY
         LvfmwmgGTpywtvZuTtnld0I2+xIzqn5g3wMHfOeVicCDnJLvfsj+j05iVRnojzL2OtKW
         FsNazqC2KhHR3ly7b6TW6BtFbrWyWUNY2iq00WUZPpvulI13ug0zDaEkFdsydReoFX9b
         91NNY+FB38mlJAdge+goH18HE3DCDe6CMRHlwOhbVqECKVINNRw9XoVn/B22OWNhA4uD
         RtWIA3dZnfgYSBl9CYt0Tew+I4CNvrT9fXFYX2v7L12WPb0ZTmtjziVMNJQF+e/i0YRB
         QseQ==
X-Gm-Message-State: AO0yUKUURiP9nHPVeT4D66qdrbiEVBOGtk30je4LYZHmfg5p2unM6OGF
	oiCA53m8jIY3zaAVi3JwKWAb7lPF8qEkwLzh/t0=
X-Google-Smtp-Source: AK7set+2S9sIoThX61XwxrWE5zE9Tsy5goZZcmLIa8T3C1STZ5MGvaivN5+KsgubDeZg3NYYIIpTriUQWAUUcABVmm0=
X-Received: by 2002:a0d:e3c5:0:b0:52f:3bea:8ce3 with SMTP id
 m188-20020a0de3c5000000b0052f3bea8ce3mr16423ywe.302.1676640515977; Fri, 17
 Feb 2023 05:28:35 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR21MB1688B4BBFCCCD01C016A62D4D7DF9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <CAPsT6hnbAA_uCiVjST8VaPgb6TyfBq9nO2S7OPqJX3=YhzBD9g@mail.gmail.com>
 <BYAPR21MB16882541DC2DA7AB91E58A03D7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y+psCbPTfF9JkW2c@kbusch-mbp>
In-Reply-To: <Y+psCbPTfF9JkW2c@kbusch-mbp>
From: Daniel Gomez <dagmcr@gmail.com>
Date: Fri, 17 Feb 2023 14:28:25 +0100
Message-ID: <CAPsT6hkYqg2N6_Xf5aL2ijydTJfPYemUVKPZFGgdAik=DwTygQ@mail.gmail.com>
Subject: Re: max_hw_sectors error caused by recent NVMe driver commit
To: Keith Busch <kbusch@kernel.org>
Cc: "Michael Kelley (LINUX)" <mikelley@microsoft.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>, 
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230217_052839_694829_6CE38E08 
X-CRM114-Status: GOOD (  20.54  )
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

On Mon, Feb 13, 2023 at 5:57 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Mon, Feb 13, 2023 at 04:42:31PM +0000, Michael Kelley (LINUX) wrote:
> > Ideally, to support
> > 512 Kbyte transfers, you would want 129 segments (to allow for starting in
> > the middle of a page as describe above).  But the value of max_segments
> > is limited by the NVME driver itself using the value of NVME_MAX_SEGS
> > defined in drivers/nvme/host/pci.c.  The value of 127 is chosen to make
> > sure that the data structure containing the scatterlist fits in a single page.
> > See nvme_pci_alloc_iod_mempool().
Michael,

Thanks for clarifying. It really helps. Also, it's fixed after
applying Christoph patch [1].

[1] https://lore.kernel.org/all/20230213072035.288225-1-hch@lst.de/

>> value to be set.  In your example, I would guess the value of 512 Kbytes came
>> from querying the NVMe device for its max transfer size. Ideally, to support
>> 512 Kbyte transfers, you would want 129 segments (to allow for starting in
>> the middle of a page as describe above).  But the value of max_segments
>> is limited by the NVME driver itself using the value of NVME_MAX_SEGS
>> defined in drivers/nvme/host/pci.c.  The value of 127 is chosen to make
>> sure that the data structure containing the scatterlist fits in a single page.

>
> Should be 128 possible segements now in -next, but yeah, 129 would be ideal.

Quoting Michael,

>> the middle of a page as describe above).  But the value of max_segments
>> is limited by the NVME driver itself using the value of NVME_MAX_SEGS
>> defined in drivers/nvme/host/pci.c.  The value of 127 is chosen to make
>> sure that the data structure containing the scatterlist fits in a single page.

Yes, I can see that. I guess the 129 needs to be reduced to 127 (or
after Keith optimization patch to 128) but not when the device is
limited to a lower max_segments value because they fit anyway in a
single page?

Following the kernel code, I can see the max_hw_sectors_kb is
calculated using max_hw_sectors = 2 ^ (MDTS + page_shift - 9),
max_hw_sectors_kb is just max_hw_sectors >> 1, and max_segments is 2 ^
(MDTS) + 1 (simplified). Using QEMU (NVMe emulation) to be able to
change the MDTS, I get the following:

  MDTS   max_hw_sectors   max_hw_sectors_kb   max_segments
 ------ ---------------- ------------------- --------------
  0      1024             512                 127
  1      16               8                   3
  2      32               16                  5
  3      64               32                  9
  4      128              64                  17
  5      256              128                 33
  6      512              256                 65
  7      1024             512                 127

>
> The limit confuses many because sometimes user space can sometimes get 512kib
> IO to work and other times the same program fails, and all because of physical
> memory continuity that user space isn't always aware of. A sure-fire way to
> never hit that limit is to allocate hugepages.

