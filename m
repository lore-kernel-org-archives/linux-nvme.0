Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1207BECAAD2
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Sep 2022 00:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=70lKWmlrtQoxiqEddVxE204zBfW5n8dIdIq2Ch1+cXM=; b=cxUfU1+G2Ww6dgXCz1v2tosUtV
	QqcyBw1bvTN9BAepHJ0VOW1HpfDtG1v2vds87aUtc3Hk9lMfMh5DKBYbOzPbvf8ELXFER+3N1/k66
	JK4QPB2fexiiqnLlVruAhup0qN2IjbwYbcURKkswnnmxb1nZAdzDUfNxyKl7yAfHyzk8AHzpC3YKR
	iPin7bJZ4HE3WhOACCcJQ/Aa7Y3Va1uzWtF6W7mEXz7WQzCI5JUTL9aPFo47KVFDMfxxQESzVfNXd
	WoWFr5DWiq1Xki6VA45H3W40eJ/SW9wwff0ksNrNujU/XDe/qVT7Ah3b4Jk1+MruElM5y5KUgMoPe
	shGWzu5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTuOI-00G6v9-Uk; Fri, 02 Sep 2022 00:18:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTuOB-00G6pq-UG
	for linux-nvme@lists.infradead.org; Fri, 02 Sep 2022 00:18:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662077907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=70lKWmlrtQoxiqEddVxE204zBfW5n8dIdIq2Ch1+cXM=;
	b=hd5zn/faT2xO5+fjzsv+jlWxT2gHTbSCOAbF/UTrTIMoteeRUIP24P0qebGTkRLW+wc6xW
	/36RfU2MJWYxfat3V9U7oc27UfI5a4unPHd8ffi9sxVgdKqDL6kt/I6xoZaiUO3EFtYZyu
	g/SyamO+VLXDu03wMYvgVeu1nVPn92o=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-156-l4VKLoR_OI6B4x0qCyMBlQ-1; Thu, 01 Sep 2022 20:16:58 -0400
X-MC-Unique: l4VKLoR_OI6B4x0qCyMBlQ-1
Received: by mail-qt1-f197.google.com with SMTP id h19-20020ac85493000000b00343408bd8e5so423757qtq.4
        for <linux-nvme@lists.infradead.org>; Thu, 01 Sep 2022 17:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=70lKWmlrtQoxiqEddVxE204zBfW5n8dIdIq2Ch1+cXM=;
        b=R2voZzeQUOSUqEKd1JM42z10+EUxeLWv+amvkqO9oDSDVoUA35wNTbvmxekgFthVqa
         mVDAr/23Pz9gVcfEY+j5PXdvx5bHL8QA8NWAJXReYyOEMYKSe2FC0AceV78cCqbn5CiX
         +qjLoOdXVJzGoYZmDMiUdqRm9uE0UQOEpqntJkXAlcThnYTKIus0LJSTYJWRuw1Ovkx+
         VrJ/5CQ0W4TLpTDK/lxOUBuietviKvvluivUEZ5ImySuax5mCydxHyJbdA/QM1UUVMMF
         tR9fKvGreFC2bs+61l4TQA44pyBwmBU/goj1Ns99kqbyhxTs0hYJtRAqR9JF2tL2QNMf
         DQyQ==
X-Gm-Message-State: ACgBeo0yWYlXeYdJ9VYxIbGnxPSk7DrWCo7O3n5zzlYrg5dVrddA+l07
	pKTXWvylh61keOwbeR2Hrzhh0Miqih7FU7jpCRg49dwjmpVA48Pg2HL3Doh5Vod6Zw217ntH3A2
	NiIoR9iWuzRsrxtu0TO10S0nmYw==
X-Received: by 2002:a05:620a:2551:b0:6b8:f97f:b855 with SMTP id s17-20020a05620a255100b006b8f97fb855mr21703769qko.260.1662077817884;
        Thu, 01 Sep 2022 17:16:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6oThe4Ex4yHgqF6bEQvTIX/Gkg5IvByk6dGpbsPU+Rt5JY04QaEnAC3Hf1+9V3KO2xRre6mg==
X-Received: by 2002:a05:620a:2551:b0:6b8:f97f:b855 with SMTP id s17-20020a05620a255100b006b8f97fb855mr21703745qko.260.1662077817650;
        Thu, 01 Sep 2022 17:16:57 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id x6-20020ac84a06000000b00342f8143599sm157323qtq.13.2022.09.01.17.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 17:16:57 -0700 (PDT)
Date: Thu, 1 Sep 2022 20:16:56 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
	damien.lemoal@opensource.wdc.com, hch@lst.de, bvanassche@acm.org,
	pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	gost.dev@samsung.com, jaegeuk@kernel.org, matias.bjorling@wdc.com,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v12 09/13] dm-zone: use generic helpers to calculate
 offset from zone start
Message-ID: <YxFLeNfAb/Uzf5nD@redhat.com>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121911eucas1p2a55dec72a6d780123e6c7655aee72457@eucas1p2.samsung.com>
 <20220823121859.163903-10-p.raghav@samsung.com>
MIME-Version: 1.0
In-Reply-To: <20220823121859.163903-10-p.raghav@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_171828_058941_C272E42D 
X-CRM114-Status: UNSURE (   9.71  )
X-CRM114-Notice: Please train this message.
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

On Tue, Aug 23 2022 at  8:18P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> Use the bdev_offset_from_zone_start() helper function to calculate
> the offset from zone start instead of using power of 2 based
> calculation.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>


