Return-Path: <SRS0=GOb3=P4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5757C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 15:15:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CDCB610E9
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 15:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8CDCB610E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cuLupL0qeqkrPOQGvhaPBdy4ZNfF/HvnVu1GlBW2I0w=; b=rKPpFeX99t1F+uVi4YAYMZ4GG7
	THiI6+i8/dh0dQC1IbzJ2WeJxRRy2NGSi3WqdPVr2Rg/+QKo07YUOryxBv/F5Np+xZQrXMFuwAzsZ
	rJMaCA7y0gOOj7ztet+Iis7tusv67UdpkRIel/ScC1/wexWqk9NjffgAqpmQvgKPBev5f52rZX6nV
	kel2h07CPJ76eCQfN2YRMJMEWM/PsPvHuY0Pw60wuI/qJS26POYKvu+RtZJoN2+6VDRsfbqVFjBU0
	z7JTHXyZRrx3nWdnE0aZXZp7FmECvxm0H/4vDiUSViP/BYhgFrWl8wEMtTSH7UvJcEAH+wv7++YYR
	rcleTI0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkSpu-002XQi-QX; Tue, 09 Nov 2021 15:14:58 +0000
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkSpr-002XQM-PV
 for linux-nvme@lists.infradead.org; Tue, 09 Nov 2021 15:14:57 +0000
Received: by mail-io1-xd36.google.com with SMTP id w22so8903210ioa.1
 for <linux-nvme@lists.infradead.org>; Tue, 09 Nov 2021 07:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:in-reply-to:references:subject:message-id:date
 :mime-version:content-transfer-encoding;
 bh=cuLupL0qeqkrPOQGvhaPBdy4ZNfF/HvnVu1GlBW2I0w=;
 b=kmQIvoYyag+9tIB/F156SVSLwPLJxQOT/kSY2gTku/cXg+WCZGtwJAsIZtOAmQnni1
 9BK5F+HdbpYw9mYqbaJN9qfLdZ+VtRV6IYn4dnxieAj/ftqzLleJJUo/oiLF3BBhE25l
 uATHJ+70MXjnINc6A/RYsiMCTGOnhPgkmf/V8aaea20ODRxMIkOaS81wx/9ayLWNw4sp
 mOkypbzdzvzXn+g1aay7QlfmEb4Zz8g26376gU+58OH9JO1wjOnuyyRtYIcmRYf6T2u2
 LMADY+MGO5bDRb+alUkIS88ocq4SoiPNdw9tdURKdIU7lqXyVZuq5XHb+oImRhS+1KfP
 MMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
 :message-id:date:mime-version:content-transfer-encoding;
 bh=cuLupL0qeqkrPOQGvhaPBdy4ZNfF/HvnVu1GlBW2I0w=;
 b=vFyuJADlRtfSEV/8Rj3ln5lT8/raxERDlodJOTLKN8iaBOjwP27k5T/UB/hJxsj/qK
 f0on8OnmXNPAHvgIz0DOGbBAobUUhD7X8ETxJtuw3675aTBuFALMAb3op4mmmTrwMwW1
 s7um7CNRWvZ4pmjmvI3qFcLFEII08drbd0e1YZCUyWP4Hcnymdf4F2bsnRRs3VxhRmNN
 ebPaq/S36twI3wbLJrZZDECIQH0gpJcU3UIYYVlnngTbsDNM4z0JppyG5fsFE+8xbYkZ
 yUV1FwFbF5Vq+oG6PDejR/B7VlfW3YTduDvSS7fmHiwma8a9nLa83S3244F0tJeHehRU
 5MkQ==
X-Gm-Message-State: AOAM531GM9cYqYkyQ/072LPhQHpgXkInaat2LCPq/1P2mR99ERxNnZds
 rmdKNTsdoiK1irX8sPcLn2WhYA==
X-Google-Smtp-Source: ABdhPJxRmOq51TfrRGB5R/m0NitxjqMuxR9iNz/jrvLmzwxbSv/3ZYKZv782sq9+OjNVuVtQi1GtLQ==
X-Received: by 2002:a02:a11d:: with SMTP id f29mr6313385jag.78.1636470894294; 
 Tue, 09 Nov 2021 07:14:54 -0800 (PST)
Received: from [127.0.1.1] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id k8sm10290379iov.11.2021.11.09.07.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Nov 2021 07:14:53 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
 linux-nvme@lists.infradead.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>
In-Reply-To: <20211109071144.181581-1-ming.lei@redhat.com>
References: <20211109071144.181581-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 0/4] block: fix concurrent quiesce
Message-Id: <163647089353.413881.8401016435701752543.b4-ty@kernel.dk>
Date: Tue, 09 Nov 2021 08:14:53 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211109_071455_853238_0E09A962 
X-CRM114-Status: UNSURE (   9.90  )
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

On Tue, 9 Nov 2021 15:11:40 +0800, Ming Lei wrote:
> Convert SCSI into balanced quiesce and unquiesce by using atomic
> variable as suggested by James, meantime fix previous nvme conversion by
> adding one new API because we have to wait until the started quiesce is
> done.
> 
> V2:
> 	- add comment on scsi's change, as suggested by James, 3/4
> 	- add reviewed-by tag, 4/4
> 
> [...]

Applied, thanks!

[1/4] blk-mq: add one API for waiting until quiesce is done
      commit: 9ef4d0209cbadb63656a7aa29fde49c27ab2b9bf
[2/4] scsi: avoid to quiesce sdev->request_queue two times
      commit: d2b9f12b0f7cf95c43f5fd4a18688d958d39e423
[3/4] scsi: make sure that request queue queiesce and unquiesce balanced
      commit: 93542fbfa7b726d053c01a9399577c03968c4f6b
[4/4] nvme: wait until quiesce is done
      commit: 26af1cd00364ce20dbec66b93ef42f9d42dc6953

Best regards,
-- 
Jens Axboe



