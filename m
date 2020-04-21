Return-Path: <SRS0=BHyj=6F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED94C2BA19
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 04:51:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0862084D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 04:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bdjyipbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0862084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K0z9iTIDyHYj/tisk91h3Ohg+zBIMIH/sn5G9YIK908=; b=bdjyipbTkwG557
	zYJ+mZNVyJxdeu0FfcsKylhTeAvkxAhrJ67DbVTaQlQ7n8G+Cnj2AIge21Mxu2SSsL2iOgBgJXNWe
	DeyUKuWlEjkibwNVSrL8GpQqIuY0cBwqFkclknyEIfReX4gwXJoWUccbu6TJM0uhVU7mgGa5f/bf8
	jWNxYFBGUq9FkiFFpetM+NFcB/TOgP3xfg/jjpw91IRJ+3rkw9S/z6ZMkYav1593MCmbEyK5oC/qM
	SNu+jJV6Pa7WoU8+JWXOsQfvTMp0g3rXq81AKM5ynLBQXMUDBwta4v0bjVHRDnpnr/tZ3DJQxFwz7
	r6qCaKQV+nYQkYTFApMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQksy-0002Ff-SB; Tue, 21 Apr 2020 04:51:52 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQksu-0002Cv-Gg
 for linux-nvme@lists.infradead.org; Tue, 21 Apr 2020 04:51:49 +0000
Received: from mail-pl1-f198.google.com ([209.85.214.198])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1jQkss-0005sb-Tu
 for linux-nvme@lists.infradead.org; Tue, 21 Apr 2020 04:51:47 +0000
Received: by mail-pl1-f198.google.com with SMTP id z9so10660473plk.5
 for <linux-nvme@lists.infradead.org>; Mon, 20 Apr 2020 21:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=yHVBi4+q+DxGUgmkg/YNM3PtmSPedofWtuQ7gpqgf8c=;
 b=jDqzBa51pEv0GAnaL6LknYzOUZsQG7HfMzijopZEHrliEV6eGTAJXPZ+Zwmv6xmGq7
 llDu5WGIaF6AToaY2LryNIQz8PfA/af7Iln6T5FZIjIsvIgFFKZ+t4+S9WMnjMOYXM37
 IZxXM7/lpkIBdGHZfaADccNf6+ZUfAvPoyk3jLDlCfOOIDkJ5FuxS4q4ECCLkZr9k5UH
 DR52SLekW4Kxr0c7YH4n8IOQ0tujmmd2yQD6HvSGhYbTu+1OLeQyr0DVOOBQaSnIanwq
 9fBDuomACXPwo6x+vqG00orBo3KXp/qL5CdhXF0s5eulyk5Lbg6reajvJLAjjJJ7iSh6
 Sssg==
X-Gm-Message-State: AGi0PuZZM6SdHfka0qAqGLvF950SvnE72tNZdAoa8vlYGQRBI0awh96L
 XNyQYxwKGAqCOLTgypRtWA8Zv/2dpjp65dC7CA6aMJ7YxBvtFSD7vU3yWIlNrwoC+6q11L3St4/
 zo11Ze8ZswaptCwL+QE6zxSNDAsSEJRMHyHRgUpwzyVZn
X-Received: by 2002:aa7:969b:: with SMTP id f27mr19363276pfk.116.1587444705578; 
 Mon, 20 Apr 2020 21:51:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypLwkVfZvPWVo80wH2SVlwC4/6KQbeXPP33zsYsSRBohoLtwxEhc5LDS6aRVK5+sLiXn4sZWRQ==
X-Received: by 2002:aa7:969b:: with SMTP id f27mr19363264pfk.116.1587444705283; 
 Mon, 20 Apr 2020 21:51:45 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net.
 [220.133.187.190])
 by smtp.gmail.com with ESMTPSA id mq6sm1074269pjb.38.2020.04.20.21.51.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 Apr 2020 21:51:44 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] nvme/pci: Use Discard instead of Write Zeroes on SK hynix
 SC300
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <BYAPR04MB49658C7772879D7BA5A6E62D86D90@BYAPR04MB4965.namprd04.prod.outlook.com>
Date: Tue, 21 Apr 2020 12:51:43 +0800
Message-Id: <39EC5974-AD83-411F-8494-70EC79DBB7ED@canonical.com>
References: <20200417083641.28205-1-kai.heng.feng@canonical.com>
 <BYAPR04MB49658C7772879D7BA5A6E62D86D90@BYAPR04MB4965.namprd04.prod.outlook.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200420_215148_685348_73446201 
X-CRM114-Status: GOOD (  10.43  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 open list <linux-kernel@vger.kernel.org>,
 linux-stable <stable@vger.kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



> On Apr 18, 2020, at 03:25, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> wrote:
> 
> On 04/17/2020 01:37 AM, Kai-Heng Feng wrote:
>> After commit 6e02318eaea5 ("nvme: add support for the Write Zeroes
>> command"), SK hynix SC300 becomes very slow with the following error
>> message:
>> [  224.567695] blk_update_request: operation not supported error, dev nvme1n1, sector 499384320 op 0x9:(WRITE_ZEROES) flags 0x1000000 phys_seg 0 prio class 0]
>> 
>> Use quirk NVME_QUIRK_DEALLOCATE_ZEROES to workaround this issue.
> Can you share
> nvme id-ctrl -H /dev/nvme0 | grep oncs -A 8
> output?
> 

$ sudo nvme id-ctrl -H /dev/nvme0 | grep oncs -A 8
oncs      : 0x1f
  [7:7] : 0     Verify Not Supported
  [6:6] : 0     Timestamp Not Supported
  [5:5] : 0     Reservations Not Supported
  [4:4] : 0x1   Save and Select Supported
  [3:3] : 0x1   Write Zeroes Supported
  [2:2] : 0x1   Data Set Management Supported
  [1:1] : 0x1   Write Uncorrectable Supported
  [0:0] : 0x1   Compare Supported


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
