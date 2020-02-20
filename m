Return-Path: <SRS0=sGEd=4I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDBEC11D00
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 07:48:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F664208C4
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 07:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d7CjkafZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F664208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Jj/C00FGKk3P1LR3dd0JU9QMoOyazjxfoO86p7IY7hk=; b=d7CjkafZQ3A/7uWO8g4pgfVC9
	HT2jKIbVCLlNLoT/YzZcBycmDfhHho3H5hI82RlZUeSCtRRR2y2kRXwV0fwA2W7hQpjAYENF0o1v4
	gnWtFC2Pq4zanaGJsj1W4OQ6rutt1SHJ9cNS0N5D65SYoxlvKhFZwherZ7e72IFL9emqBS7ugpakG
	LbQ5C4/ZVMO+w8MxAMjNwgX6jyP4hdmlTpFV3V+4x0USTdCHwqIjoClvoijx50oAbmeDUBaDQV7bR
	hm0z/J4X9cOsuMf3ZM4+ckPms4zWhct3wLKVQFSmWZNtxkK8n28p7NVd+kvNPViGL6tgKeRldpmK5
	7yFjmZwPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4gZH-0002rs-9Z; Thu, 20 Feb 2020 07:48:19 +0000
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4gZE-0002hO-UW
 for linux-nvme@lists.infradead.org; Thu, 20 Feb 2020 07:48:18 +0000
Received: by mail-pl1-f193.google.com with SMTP id t14so1218014plr.8
 for <linux-nvme@lists.infradead.org>; Wed, 19 Feb 2020 23:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5OqCh4aiWS9i6W7YkiqdtmHt+0LOCXjkb1xKrH/aSdU=;
 b=qc2stDQ3RBErrPo1Wty7cYcmDZitdH//EeWW7Mj16v5izSUynhWP/Cgmz6Q65G2k6Z
 WxrVt+xhc/9DkQSwNuFBZW0It7ONXG8DteyBqkNvwIYYKxi9FjJgSMrA7ROPeY1d08Ff
 l50DsdcIWNuRhHMhh/WQWJbFdiHj4e1O7oQ+WhjT6l58c7K+CcR1fbq2yEvmQL+KDIbC
 doaopF1DZ/srTmMDpkaxd6k7qXcAnqb+IVONFbyqkeGuaaXUvMzQRqDjjIlfttsqxS7Z
 QxtpMwg0ezRRUcqCV62Nmqnmi/g/s3oTrz6oGqzsdJDlXbnILFhygk3i4ZAiVAMv03Dd
 31LQ==
X-Gm-Message-State: APjAAAXVjm/lUXE9HEUOOX83hHgBebBrT6B2KjJSuzWbJ9DTT5VlDawr
 h3rQcapxaMarbNAP7C9rvWUQpF4A
X-Google-Smtp-Source: APXvYqzO99Uu8ybwMYpTWUezCo+KCv/UL7C1zhkryVXQBd7lXM5SmAZRyEvb2vj4Q+eCpQoffiluNg==
X-Received: by 2002:a17:902:9a8f:: with SMTP id
 w15mr31327450plp.30.1582184891426; 
 Wed, 19 Feb 2020 23:48:11 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3910:5e55:b19d:2395?
 ([2601:647:4802:9070:3910:5e55:b19d:2395])
 by smtp.gmail.com with ESMTPSA id s14sm2265626pgv.74.2020.02.19.23.48.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Feb 2020 23:48:10 -0800 (PST)
Subject: Re: [PATCH 0/4] nvmet: add set feature based timestamp support
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200218214338.25088-1-chaitanya.kulkarni@wdc.com>
 <20200218231007.GA18306@redsun51.ssa.fujisawa.hgst.com>
 <20200219145907.GA17748@lst.de>
 <BYAPR04MB57497EB1A77974AF57769AEB86100@BYAPR04MB5749.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <51465fc5-6f49-5790-4d85-df5f841e2f8e@grimberg.me>
Date: Wed, 19 Feb 2020 23:48:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB57497EB1A77974AF57769AEB86100@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200219_234816_989445_AF07F084 
X-CRM114-Status: GOOD (  15.80  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> The last three ought to be a single patch IMO since those should really
>>> from an inseparable package deal for this feature.
>>
>> Agreed.
>>
> Agree, just made series into small chunks so that it will be easier
> for a reviewer to go through changes in a botttom up manner.
>>> As to why we'd support this feature, the spec says "The use of the
>>> Timestamp is outside the scope of this specification". Is there anything
>>> interesting we can do with this?
>>
>> I can't really think of why this is useful either..
>>
> If a host is dealing with different controllers which are on a different
> machines it will be easier to sync timestamp and read it's value.
> 
> Although spec doesn't specify the right use, having this feature will
> allow application(s) (if any) to use it if needed.

Do we know why is that needed?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
