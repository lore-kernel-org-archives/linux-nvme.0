Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B7DC2D0E0
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 15:54:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244D520770
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 15:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZxnkNaRK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="LwMt9q3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244D520770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WMqhs4FkwiJDWbbG5rgyf8L7UsPjcqWcqS4CU7kWYNc=; b=ZxnkNaRKrWx272Updw/6/2prg
	mdE2pzDoesQi2OAQtAhkQIw0WbeyUIBntIHHv7Wg6aEu0o+10K9VllNOMaAO/fYBC4fShTi9q9FYi
	DliFVuVjiSSZ4a9AWjlS/p+EcSKXl+5gbq839BcCUT2d9uYECQoMTjC8MYrWUMLeEW6YNznZNUUj5
	6EfgJ88fVQHNAVUhvjAkyEb9peCr6h1pA3SfqJQWB4mWWcrU/SA+BU0uVxe6dgSnkU8aimQrQLuKo
	pJhv/QaJ3o2TOMZLHsosywK1fsiFQ8U3a339hcFzFvNad1nnLagGwwaEYI99aZJUxh0LT8hC3UFjX
	ZgyVN4zRw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kEE3E-0000yK-BF; Fri, 04 Sep 2020 15:54:56 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kEE3C-0000xk-9A
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 15:54:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bPDLBSQCrYXiG/Q7VJEXsW9lcd/dlPjbrasizVEeGk4=; b=LwMt9q3JbxefppAMs1njdZsF1M
 iIvJ/wyQkPkKU8ViZcefyvvDx2vQI1+phJtdYEoo86B7xXSx1LUhLRyHuE7oQphhTiOCXDf1soY7j
 igJidTqfuiiaGzUFVRmQb+tHu2oOYyBNKHto8/edHyXiia9ySW5lxGNLDQT5X+bgF+2PXtK/imSSj
 uR3f7CrHiSrIyqlZS2CfEhGzirennOsSzlLp7e/qTRkASqNWn6+T0RSU1Thb0WCNNkw1oy+ExL+l4
 MdyX0wqjDecr2cloYgo1bGm7OyPH7+RDQigMEdzUNKis9AGXb6EQ2BiG/PWITBieBke/eltFUv7cX
 uQlTnvEg==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kEE3A-0007pi-6z; Fri, 04 Sep 2020 09:54:52 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200904023929.5320-1-chaitanya.kulkarni@wdc.com>
 <20200904023929.5320-2-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <16dc2193-9830-6184-e7f6-ceaca5f0aaf0@deltatee.com>
Date: Fri, 4 Sep 2020 09:54:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904023929.5320-2-chaitanya.kulkarni@wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/3] nvme: decouple nvme_ctrl_get_by_path()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200904_115454_331902_48CBD966 
X-CRM114-Status: GOOD (  11.90  )
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



On 2020-09-03 8:39 p.m., Chaitanya Kulkarni wrote:
> Right now nvme_ctrl_get_by_path() accepts ctrl path, based on that it
> opens a file and calls nvme_get_ctrl(). In order to take module
> refcount it is important to distinguish the error between file_open()
> and module file ops check so that we can unwind the code in the caller
> nvmet_passthru_ctrl_enable() in the error path.
> 
> Rename nvme_ctrl_get_by_path() -> nvme_ctrl_get_by_file() and lift
> the file opening and error handling in the caller so that we can unwind
> appropriately in the error path.

I still don't really like this idea. No need to keep a reference to a
whole other file.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
