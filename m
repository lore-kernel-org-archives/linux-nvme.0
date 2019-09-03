Return-Path: <SRS0=NjBy=W6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6675C3A5A2
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 19:11:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BAD23400
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 19:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qJmexCfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BAD23400
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7UOQwXBhkHyY+DjX45pgDjN8gwvUoqFL9s0fbBQEQZA=; b=qJmexCfz3SaOFuVgxn7Tj+GaT
	QxKZyFYnvs3rUx4AfyNPk79C8TflnxXMbKzoGGMWO5Swhux1H8kx8lPeWngNhj+tEOKQVcdzfRt6Q
	LxY8uynmcrjOuaAWSQ82Ss4E3kdyJlvfnrOO+qmwQW8pqvRaWsa2E+p7hnhQ7kxcs9ahQrj2OyyEO
	dD/M6ctCrxyZHGrBV9ITUkfHMNzPXmxJrJIpqvXvMNU7idRxxMSOFcl6Zzu+Rwynh+L1In48HxL+t
	K3BwNSmFsqf8HN89CzTu+EESgXuuv7Ny7b2Y2Xgt4X8A1t+PZUCFI9at133y11LdvtXEzixcbiYN5
	WybcfvcYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5EDP-0004Kh-9Y; Tue, 03 Sep 2019 19:11:43 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5EDN-0004KK-M9
 for linux-nvme@lists.infradead.org; Tue, 03 Sep 2019 19:11:42 +0000
Received: by mail-oi1-f196.google.com with SMTP id w144so6716325oia.6
 for <linux-nvme@lists.infradead.org>; Tue, 03 Sep 2019 12:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=URWBJCKMLF9JrQV153//VBnnjZqNM/DWZOjYUVblmIY=;
 b=a5BPYxSj9FwDOEtRHb1PZWcH1Od+CYw4g+RXqxDKyXxV/TrXQPuwEbyj+W8ML2Rjv0
 Su2i6a9lFQNLpZedZzy+DFu/UDzB7hkVOSMHA9tBCqcNP8HJ7uWttHkbvyQ/2JXiYpwp
 zfU/Cts6hCzEN4vhbFiEojVDBmVGbSG5K2jtw7r7MKfienQH/PrLQyth6+8h5WGo9dcq
 4n9YgbDGqaiolfPxFfyYfiS9CXeYlccQcmTDAgRxLkPJ7BezZufkCfvFzlmrIF9HsnRn
 ugLPqFqcVuVBpN/D3oVKPLgSnvRAhvSXD/vhBiiNUwtpc/BlJKNMXp+7oi2IwshNsbqX
 wHPw==
X-Gm-Message-State: APjAAAXSkGq7AljEmTaWpV/mBGTzp139D44nZtOJsEOjkY9WMneoKgMO
 mMkZlNTmjs8taG3v9uT+ZlQ=
X-Google-Smtp-Source: APXvYqw2DmMHc5CE6UqqDkMZBdLNVpTfYTQiChaGEcROJ4Re4A9GNp3jUMs7eGed5eTqcfve2kcSJg==
X-Received: by 2002:aca:edd4:: with SMTP id l203mr683897oih.52.1567537900120; 
 Tue, 03 Sep 2019 12:11:40 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id e1sm919082otj.48.2019.09.03.12.11.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Sep 2019 12:11:39 -0700 (PDT)
Subject: Re: [PATCH 1/4] block: centrelize PI remapping logic to the block
 layer
To: Max Gurtovoy <maxg@mellanox.com>, linux-block@vger.kernel.org,
 axboe@kernel.dk, martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
 keith.busch@intel.com, hch@lst.de
References: <1567523655-23989-1-git-send-email-maxg@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8df57b71-9404-904d-7abd-587942814039@grimberg.me>
Date: Tue, 3 Sep 2019 12:11:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567523655-23989-1-git-send-email-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190903_121141_726986_EBD48A42 
X-CRM114-Status: GOOD (  10.27  )
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
Cc: shlomin@mellanox.com, israelr@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> +	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
> +	    error == BLK_STS_OK)
> +		t10_pi_complete(req,
> +				nr_bytes / queue_logical_block_size(req->q));
> +

div in this path? better to use  >> ilog2(block_size).

Also, would be better to have a wrapper in place like:

static inline unsigned short blk_integrity_interval(struct request *rq)
{
	return queue_logical_block_size(rq->q);
}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
