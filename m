Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0ADC433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 14:26:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0FF2312B
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 14:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I8EH/j0e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmI5IRsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0FF2312B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fhbhxvYK5H2sYrQxp6X3Ixm5sIATjR9xPFzzW5124Ao=; b=I8EH/j0eAfGjN0tthbat5Bdgy
	wtiehS7aSruTEa5mamNv8ddhRj2rIe7QtOXehOAfYy6I7r1Z1ydX7rrPsVnINNvAPWcoLQm9r5qC1
	1O47qVzHtnwBrxT39DppdqRqKL3HncixTxhs1IEj2j8pJtkd1brc1pnoxGE0G57JQdg9yIFtnDcNg
	ByvevyNnuayr0qTCaWt/wRhxIlKA6X+r3h83tz42EXPHSujGeBHrIT/0rmBCd9Az3PR1Q35C5OrJk
	UlD5GASNYvwd67MdbAQvvWdEPa15kxFd2AuviKUke+K2mRp6rNthIyKHl8qbh/lDdq/22YrHWrB4v
	nKRJPl17g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3gql-0003tL-EN; Thu, 06 Aug 2020 14:26:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3gqi-0003t3-Ck
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 14:26:29 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AA1D92312C;
 Thu,  6 Aug 2020 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596723987;
 bh=yVus2+dWYOrx/8adKBpOD686gNxw7G1mA9r6gZEVo9A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FmI5IRsC8Vr2+p+7BYQQtJjv/R32E+EfS2F5E7znUhxhc86Y/ATJnftZPdsT0nbW+
 0+WIeiysgvOGthMs6+S36XNHiE/q3YD1dRmnlzzI6JI44DZfx/GfFuX1tU6d6QToNf
 dacI+lUvndk7cvokYCSETWZB8byNMsE+qq3tdHug=
Date: Thu, 6 Aug 2020 07:26:25 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH] nvme-core: fix io interrupt when work with dm-multipah
Message-ID: <20200806142625.GA3075319@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200727055818.21430-1-lengchao@huawei.com>
 <20200728111956.GA31546@lst.de>
 <6df01884-5498-0809-b358-0c9f7d775a73@huawei.com>
 <20200729055903.GC31113@lst.de>
 <43e5dee8-1a91-4d8b-fdb5-91f9679ddeb3@huawei.com>
 <8d01b123-478f-f057-1598-8283dd099b03@huawei.com>
 <20200805152905.GB1982647@dhcp-10-100-145-180.wdl.wdc.com>
 <255d55e3-f824-a968-e478-3efeda095696@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <255d55e3-f824-a968-e478-3efeda095696@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_102628_523219_673F3828 
X-CRM114-Status: UNSURE (   9.63  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-nvme@lists.infradead.org, John.Meneghini@netapp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 06, 2020 at 01:52:42PM +0800, Chao Leng wrote:
> NVME_SC_LBA_RANGE should failfast, because retry can not success.

The DNR bit is how NVMe conveys such things.

> NVME_SC_NS_NOT_READY may retry success, but the probality is very low.
> NVME_SC_CMD_INTERRUPTED need retry, according to protocol define, retry will success.

If the upper layers set a request such that "noretry" is true, that's
the behavior you're going to get. Sprinkling special exceptions around
is not a good idea.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
