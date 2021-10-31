Return-Path: <SRS0=mUzn=PT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67216C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Oct 2021 17:48:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A7560FD9
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Oct 2021 17:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F3A7560FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7MuoEHjjO8VeJaVuFed8XWzS0lEfBBHPNJTbN9pP/Kk=; b=0CsNFqFaSS0VXfVtli1UR9hX0n
	RymM7PksPVJzlxbxJHguOlB380FkYANFf6b3bAupIvrxOil9ixvtvmaa4AcvmACf8BY3KtIdeFVp6
	26YNwMcIzk2XQZHz+ohnu4AzZ0mQCqL1suaEii8DOF0TzZtZCu4QaLKaFZicba5Az3xNII5I+40UJ
	IQJrCb6xmJ1BVp4Em9OZ+xzf/JqFuG2nbIFrjvDua2wc8xlbwnqyyRTPjgESIfN8YrDvqIN+x0hN5
	SLMxsxbVsrYtJFIkrSMbkUILG0povI4XDH728kJXA5nE66oodm9ATnNp06W/FULwMgcsRLkj8DJwj
	nWjN0m3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mhEvz-00ETKW-SH; Sun, 31 Oct 2021 17:47:55 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mhEve-00ETHd-HQ
 for linux-nvme@lists.infradead.org; Sun, 31 Oct 2021 17:47:35 +0000
Received: by mail-pj1-x1031.google.com with SMTP id
 o10-20020a17090a3d4a00b001a6555878a8so2951897pjf.1
 for <linux-nvme@lists.infradead.org>; Sun, 31 Oct 2021 10:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7MuoEHjjO8VeJaVuFed8XWzS0lEfBBHPNJTbN9pP/Kk=;
 b=4tOJMdKFSRsgNH+AUIYaqm2kjoYMRFX1rF2DJJ+SkN3TxFcC6WFZTlfZ/p19kQbT9K
 3ucowaD3UjTRl1wxq0AhkO2grIrwJ1CUzZL9iaOW9qQruYwZiNTLyT8xPdcntcGZTnKO
 oHouSuIItcBdIuUQi3se1/cFTWoJaoIMfatJqvTJNtdVS5k8eQGd7+SN6PbVUPLsaGtZ
 l1ZNkN5xiSBdq4V2xHL4j3AS7JUzTTQy6aixWFwT8tGnH7btlFyMUA6OKqRZ3rOIuHsc
 1ZLLqjh17RQWY85HyaOON7GqX1MfrrlXjw7ctSAkgQItKO1cowEaIPOliTgHjuC8pBHM
 Mnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7MuoEHjjO8VeJaVuFed8XWzS0lEfBBHPNJTbN9pP/Kk=;
 b=lIhg1ALezbl8IWM1bm8B4VBohq+Y9o1k9u/ACAf8E74MGygrV2Rip9RTsDdyX+hX7y
 6HwSSXMl+ypvyzEykRjHQmoCPCnpbvu6P+1QQbyvuMj9yoFNmd312NyHXEnEmlTSGZmJ
 +w+MfeZX5ydqexYS61NDsqUOjXtVrXwpv7tnoZpEzA2TlR9h2EpQdFhM0sdOitlumcvZ
 F3JPPFbzLlFTKQn5j9A3h949x6aQfGt4Pk+7afE6IwG1f8sDiXkAsDoV7b0Zha9VlxSp
 9tJoW+xmMc18o5GMkesLXKPPIv93uMzOTo169rkJfR5lw16tGOjSSnoLACZtRms3fUIV
 nkTA==
X-Gm-Message-State: AOAM532MBIDsnfdyI6t5hpBs5yM+NVVXeVmnQT7XMsm1W0MDuzteEpGL
 pHPs4LT0VmMoKKlnkGa4hUEv/5WbIqMTVEpxwU43pw==
X-Google-Smtp-Source: ABdhPJyA7Laj0AUg2FKVlcU7XOrNA0zdW+Ju6E23SLHq82Op6ARxl3h9QltxEajuidxiYWqVOR7E35WaYaY6PyVeaf4=
X-Received: by 2002:a17:902:8a97:b0:13e:6e77:af59 with SMTP id
 p23-20020a1709028a9700b0013e6e77af59mr20648644plo.4.1635702452583; Sun, 31
 Oct 2021 10:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211015235219.2191207-1-mcgrof@kernel.org>
 <20211015235219.2191207-4-mcgrof@kernel.org>
In-Reply-To: <20211015235219.2191207-4-mcgrof@kernel.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 31 Oct 2021 10:47:22 -0700
Message-ID: <CAPcyv4gU0q=UhDhGoDjK1mwS8WNcWYUXgEb7Rd8Amqr1XFs6ow@mail.gmail.com>
Subject: Re: [PATCH 03/13] nvdimm/btt: do not call del_gendisk() if not needed
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Geoff Levand <geoff@infradead.org>, 
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Paul Mackerras <paulus@samba.org>, Jim Paris <jim@jtan.com>,
 Minchan Kim <minchan@kernel.org>, 
 Nitin Gupta <ngupta@vflare.org>, senozhatsky@chromium.org, 
 Richard Weinberger <richard@nod.at>, miquel.raynal@bootlin.com, vigneshr@ti.com,
 Vishal L Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 "Weiny, Ira" <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, 
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-mtd@lists.infradead.org, 
 Linux NVDIMM <nvdimm@lists.linux.dev>, linux-nvme@lists.infradead.org, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211031_104734_609457_129F4EEC 
X-CRM114-Status: GOOD (  14.89  )
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

On Fri, Oct 15, 2021 at 4:53 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> We know we don't need del_gendisk() if we haven't added
> the disk, so just skip it. This should fix a bug on older
> kernels, as del_gendisk() became able to deal with
> disks not added only recently, after the patch titled
> "block: add flag for add_disk() completion notation".

Perhaps put this in:

    commit $abbrev_commit ("block: add flag for add_disk() completion notation")

...format, but I can't seem to find that commit?

If you're touching the changelog how about one that clarifies the
impact and drops "we"?

"del_gendisk() is not required if the disk has not been added. On
kernels prior to commit $abbrev_commit ("block: add flag for
add_disk() completion notation")
it is mandatory to not call del_gendisk() if the underlying device has
not been through device_add()."

Fixes: 41cd8b70c37a ("libnvdimm, btt: add support for blk integrity")

With that you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

