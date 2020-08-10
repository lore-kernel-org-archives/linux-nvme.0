Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F4BC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:32:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D5A206DA
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TDKAkBiJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="XmbswCsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D5A206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XXGRHqvi2xvnK0T+csg+iI2DJ62SJEFYPKE5u/Va0ik=; b=TDKAkBiJzStZajCOjofsLirO7
	TW9UFaeqsGB364kwdDNVfHWoR/7JShlriNupkkvDE4IrGoeIRtEqUZpNtHyOwxSdSi8Q8dptzUsgO
	UmnPp9R8Air8IbZN2wIRffTrpXRtvU3XCwnbaLACpQ2kc5q4jeWOAA97zZbed7AM5iNtzWFCQmo6e
	AY+tUE0Uf6gsc9/3RzmFIP/5rVNM+jpYZoFTipoiSeZXB1TXSqZ1hPPSNUqUtDFhD6ukKe+dOOsW/
	pw0TtOOVirrORKGgLynWS0UUY9G+2rzB1Slb9QhibuWgKvYV4P6OCV/FFLwijkLKS3W5ODGL3R0Co
	inUVCzxEQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5HHD-0004nz-Sl; Mon, 10 Aug 2020 23:32:23 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5HHB-0004nZ-Nb
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 23:32:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KjqvYS+FbbDH9DgaiRfXFjsfpGkCZFL9s9rq6OD4cOY=; b=XmbswCsZbAbYyjNyHUldVzK9ZJ
 k0HSD3TBr5j8uI2fiaCusiTX5ti+o8LHI5dILAsoT/DnIXDm2ok+IbiADQLEgeJYwT6Rvlg+c8cye
 Bd3WuEqC0PLU/LmE463wJ0IKBkhAJjjAhiJXtlTsDydePbUrAD7qTlVoS8yOoBF5blsuB+djrCcyt
 5G1HaQcNowdRcQ+ycJB4UXyZofV3vNYmG3A46FUvK3GI16XPTSWL8ajidlYbcaP0kyworxunt/9i6
 EVB0sLmrhm6et96EmvCM5EQvdPjMf705GtUQrbnccnBuAHCFcKu7fABdalz6oX0Uk9UuW1AR01bl2
 /yCWpiIg==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1k5HH9-0002CF-37; Mon, 10 Aug 2020 17:32:20 -0600
To: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-6-chaitanya.kulkarni@wdc.com>
 <f7dfd268-9b02-4711-85d4-eebd8614f8d8@deltatee.com>
 <BYAPR04MB496523DC21401582BE98753C86440@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20200810231346.GD269401@dhcp-10-100-145-180.wdl.wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6bf9d5d0-6101-029d-c273-352bfd7f332e@deltatee.com>
Date: Mon, 10 Aug 2020 17:32:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810231346.GD269401@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
 Chaitanya.Kulkarni@wdc.com, kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 05/14] nvmet: get rid of the extra variable
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_193221_841964_E5FC64BB 
X-CRM114-Status: GOOD (  11.89  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-08-10 5:13 p.m., Keith Busch wrote:
> On Mon, Aug 10, 2020 at 11:00:55PM +0000, Chaitanya Kulkarni wrote:
>> On 8/10/20 14:58, Logan Gunthorpe wrote:
>>> IMO, that's really ugly and not at all an improvement.
>>>
>>> Logan
>>
>> && operator is perfectly readable when use for short circuit two 
>> conditions, more than 2 or newline is what ugly not this one.
> 
> The odd looking part is mixing "likely()" and "unlikely()" in the same
> conditional.
> 

Yes. Also, I've found kernel developers generally prefer functions with
long imperative names to not be used directly in an if statement. Just
search for 'if (ret)' in host/core.c to see many examples that could be
folded into the if statement, when they are not. Only functions with
names that are predicates, or answer questions, may be used in if
statements.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
