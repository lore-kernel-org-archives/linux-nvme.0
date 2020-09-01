Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468CFC433E7
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 17:00:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03994206FA
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 17:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KQxah5Zb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="JROWvsfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03994206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hXo5Ds0b6HTVsYsz2XiBXUo0oevnbs1TaIY6qhSHoGw=; b=KQxah5ZbdpP6IYpRu57DGPGwP
	jguhDgT4dddOquf0f2/PgB+B9olkpWMj7ICQJmSIxyS6Rf3RuuArHsyapqEokIP/OqsTaYcC029Px
	ElVNYP1B+oa0CgUxxhrzSOAKcy7SVj74cC/2lnteUwrQKGRo1vwHzZPyVqxKwg1DPPwFaWxo/Y9wP
	a0jtZdkHkhoKEZ+B+unqxLAAmJmrvr87oRApwIc0uZudJTsG9ZYMPaiVkI6WFxh60FiQV0wC/ipKO
	l9xORIcQwzbSEse3dG47vk1Hk/60tL1qJ369H0CSly0UWlNBgWYuCGzTIdZaUEWGd+gGgnCr0eozq
	1AlnjvjOQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kD9ds-00011X-J9; Tue, 01 Sep 2020 17:00:20 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD9dp-00010Y-8G
 for linux-nvme@lists.infradead.org; Tue, 01 Sep 2020 17:00:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k9In1UsbUlBZErVa4i1dOqqb9WPSGJTGJeQSGHIW9SQ=; b=JROWvsfMxNRHvVZXuR94K51xEC
 yMGh2zw9jIQUvEWWX7X417mefVAnxtyAXbqncV3GbhI/1D/RO4+CSWxe+iPPB/9D1jImV3LeQS4wF
 FFcGCg7wvIYj1gMOlEgX9fHXNBoxz4oxW+hMvdk7xcXiAvm9ZGVIY1oprRpfC1xWkCGDY0BEuXBjH
 7zc0koDWx9vWdo8YRzqtl7VBcRKWnBOp8/mRQG8NqjBHpvKvVJRcKH0fdKu2/aaohXECDJMLHmU6f
 OowF/NYPVfwczJhyNpm+2dy1yzQqmjpySXb4kVBz2G/NZMguzx8Jwcq1iRPsuKIoC/XjBsmJ8wV5b
 boAZqHaA==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kD9di-0006eY-UX; Tue, 01 Sep 2020 11:00:11 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-8-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ad9ccaa3-0aff-038b-211f-8ef401321ea9@deltatee.com>
Date: Tue, 1 Sep 2020 11:00:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831222707.35611-8-chaitanya.kulkarni@wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
 linux-nvme@lists.infradead.org, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH V2 07/12] nvmet: decouple nvme_ctrl_get_by_path()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_130017_362770_D6B1FA8D 
X-CRM114-Status: GOOD (  12.49  )
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
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-08-31 4:27 p.m., Chaitanya Kulkarni wrote:
> Right now nvme_ctrl_get_by_path accepts ctrl path, based on that it
> opens a file and calls nvme_get_ctrl(). In order to take module
> refcount it is important to distinguish the error between file_open()
> and module file ops check so that we can unwind the code in the caller
> nvmet_passthru_ctrl_enable() in the error path.
> 
> Rename nvme_ctrl_get_by_path() -> nvme_ctrl_get_by_file() and lift
> the file opening and error handling in the caller so that we can unwind
> appropriately in the error path.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

I don't really like this. It just seems like a lot of extra mess to keep
a reference to a file object that we don't really need.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
