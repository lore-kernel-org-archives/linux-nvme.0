Return-Path: <SRS0=1/6V=3F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62628C33CAF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2020 22:06:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3316F2073A
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2020 22:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XOvJqskX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3316F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gTs3SmuPethgxZDL74JEglC+la7VZ9TME+R+MZngNVY=; b=XOvJqskXljmGg5FUHtBIauKpj
	Sc4ogAhKnTCFe3MktmftQHD9/hdbU/Tac4ULoAQHGe6t2fWbbeH2jkEK1J46NSBsDmbpcIs3QKEvH
	AbT50T+qT49XA8ZvAFuH6YEGoC2EX1jNUNBHW0tQ0Dw5XHoSfVJM4sszNuBgPUSz7peoS1D/ggCY3
	ryEaSP9iIC23IusNWQSvpzOYYRpn/zjxSMb74UgkqseJh5rxSQuEzWZGXmAdegqQUfCjdBl+y0Gp5
	23fKNhk+TA1jA/oafwGjdjLRhLBeJEwp9jLN8B3xMt3I3uJyBQFLhbJ9u4rcPDnufZnXpCa2QnhOS
	MjX/ME9AQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1isDHv-0008PH-64; Thu, 16 Jan 2020 22:06:51 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1isDHn-0008Og-DW
 for linux-nvme@lists.infradead.org; Thu, 16 Jan 2020 22:06:49 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Jan 2020 14:06:41 -0800
X-IronPort-AV: E=Sophos;i="5.70,327,1574150400"; d="scan'208";a="218694742"
Received: from edmundna-mobl.amr.corp.intel.com (HELO [10.254.102.222])
 ([10.254.102.222])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 16 Jan 2020 14:06:41 -0800
Subject: Re: [PATCH] nvme: clear stale nvmeq->tags after tagset free
To: Keith Busch <kbusch@kernel.org>,
 Edmund Nadolski <edmund.nadolski@intel.com>
References: <20200114181745.2297-1-edmund.nadolski@intel.com>
 <20200116160602.GA28993@redsun51.ssa.fujisawa.hgst.com>
From: "Nadolski, Edmund" <edmund.nadolski@intel.com>
Message-ID: <0ff9ee57-0211-0170-7c58-a6c5d9354beb@intel.com>
Date: Thu, 16 Jan 2020 15:06:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116160602.GA28993@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200116_140643_496912_4B959AF9 
X-CRM114-Status: GOOD (  12.42  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/16/2020 9:06 AM, Keith Busch wrote:
> On Tue, Jan 14, 2020 at 11:17:45AM -0700, Edmund Nadolski wrote:
>> +static void nvme_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
>> +{
>> +	struct nvme_queue *nvmeq = hctx->driver_data;
>> +
>> +	nvmeq->tags = NULL;
>> +}
> 
> If you've multiple namespaces, disconnecting one of them will cause the
> shared nvmeq to have NULL tags, which will crash the kernel on the very
> next CQE read.

Currently it crashes with just a single namespace, because the nvmeq->tags is 
still pointing into a tagset that was previously released by calling 
nvme_free_tagset() from nvme_reset_work().

Perhaps the driver should not free the tagset unless & until there are no more 
namespaces?  Is nvme_remove_namespaces() supposed to ensure that?

Thanks,
Ed

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
