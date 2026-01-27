Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B33D2FED9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jan 2026 19:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Nelkyz1DwIXiGdmAwkkHf/1f9ijeOdEKCLoXCN3G+M=; b=P8xGbnCNunUSQJgASMTIwxXyRu
	WrM3aszjVo7pbzk3rJCy911DUIzxrPXfgOiGjwlTt+t+u6XhT+xmtVYNhyWhIl8gcUnGwl3c0BkJC
	+OTpjZe0xJQqM2LMSKh9ttgoyoVn+9mjSrcWudStZ5A6EquTDCDBCgkmilcbP7Fe/O6QaOQmLVNOe
	bW6rNyLVWe7UxQUz9ls6zZXvFYZbU6UYE/hwCdUaxigUbEiuOXjweXBmoQYRBMhJixVc687r+tW9/
	3TjOekmWQ6RWdN/fui5NMIWHsP04LCn0Eur8rgfinP/opp5dfBCbbc7kXG1RHgDn346hP6Z/xxy8U
	4gTTWDsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkoTh-0000000EtLt-26XM;
	Tue, 27 Jan 2026 19:11:53 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkoTg-0000000EtLV-34qB
	for linux-nvme@bombadil.infradead.org;
	Tue, 27 Jan 2026 19:11:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=/Nelkyz1DwIXiGdmAwkkHf/1f9ijeOdEKCLoXCN3G+M=; b=E2sMejYsSFmwPvtgznS+XgudG/
	Ve5V0WF7g6sqwC3RhEUsp+1esRUPEA39M8FluqQGDsqS2OVk+1j2UDNF3pUoNyzP9pRLWg9vZvz+d
	rLuH3aaGmelk0BHz2O5zfuZEgdqpoZ2DfauOfZ//Z0rWeUtohZdhNV5Bre2EogKvxtovjv1nDgRBP
	6svQhg+NCWgwwB8h/1kzpRe8leGk/5CDl6uP5i29MXly9+WBPc8t9RLKUoPfoDC3PoPoqjAfYtwlc
	c/sm8Q2QAf1fjgVEqZYEQcQ8kylMfHLtl7UOV24PEDWH/wiOQ4T7Xh1YLdOHps8J1vJQhj24rqvNS
	o0t0l8yw==;
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkoTd-00000007Ttq-1AcX
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jan 2026 19:11:51 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4f0w4P3Vj4z1XLwWq;
	Tue, 27 Jan 2026 19:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1769541091; x=1772133092; bh=/Nelkyz1DwIXiGdmAwkkHf/1
	f9ijeOdEKCLoXCN3G+M=; b=VX3cQvzXloGUZCdvcYCnkOqyMZ1JbJpoNhMNSk45
	zGTbleVrPtQFz1KO7XlJC0rXsBTPbxQpGkg9KqI9ASKQNOwyr0zQI9I2kGAk/gWQ
	6Nn+2H9bos6FHKvDYTHsdSp8iRXxFdgRbYCNDmtN8Z4itKiMKVAxgsM5bett+MYA
	ARk/sTpieRpDybGN9uoJby4Z6mWpvsKZqIdI8CKPsI3hEYnSNKEO7hf3JG5vGdal
	z+CG2cxPvxyPO4uwevRmtyeAaBfI9k/IIhekTdkyCM8PmaSefcR4niEwYiyUKfXD
	/+M67wedPrmQ8U9nxe32XK1/PDrzdX2mXIL6rJP11bgzHA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0hSH0Or-G6py; Tue, 27 Jan 2026 19:11:31 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4f0w4L2p2jz1XLyhf;
	Tue, 27 Jan 2026 19:11:30 +0000 (UTC)
Message-ID: <6d648dab-fe05-437e-be25-6c026302322e@acm.org>
Date: Tue, 27 Jan 2026 11:11:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Block storage copy offloading
To: Viacheslav Dubeyko <slava@dubeyko.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, Jaegeuk Kim <jaegeuk@kernel.org>
References: <0cfe6fe2-3865-4dc2-92a7-74b1240f7b63@acm.org>
 <eab078c99e17e45632c6b35e2fe1145e9459ff2f.camel@dubeyko.com>
 <5273400e-5cf8-4d70-a85d-accfb2977d8e@acm.org>
 <fcd8fae5950ea5888eab5279fa3ebcad1d27bfa4.camel@dubeyko.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <fcd8fae5950ea5888eab5279fa3ebcad1d27bfa4.camel@dubeyko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260127_191149_614163_42AD980B 
X-CRM114-Status: UNSURE (   6.03  )
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

On 1/27/26 10:03 AM, Viacheslav Dubeyko wrote:
> So, frankly speaking, currently, I don't see the generic technique that
> can work for all LFS file systems.
If I change my topic proposal such that it says "some LFS can benefit 
from copy offloading" instead of "all LFS can benefit from copy
offloading", is that sufficient to agree?

Thanks,

Bart.

