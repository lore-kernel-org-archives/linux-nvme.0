Return-Path: <SRS0=ulAu=GW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CA5C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 14:20:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7792312E
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 14:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7792312E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=psl6u6vZIWI+Q2K4JkHyzfrRf3C48FsShm0zROkIAE8=; b=g5WelzKIFl32TruYMol+fcZDn
	s2BCU65pCZYl7EAvHmYRSsvAUBmXDtLkIG/ufu7/pjjgVskn4Plqx4OL2fZI+A7eSe8FmyiBZN8kM
	KlvFHrsvC0XzKxQYw3dOHvmjDM4X4EMKq8C2hyc98fr7c3k0oK++s5Ymzgk4W7Q+5SQISgl/PsnPV
	nhm6NbL4eklPN4DucOZTKNJmOJm8HfGxzxDejhVrrk0Xcl/NhAEiEMfdGm97hKce5MeKyi15FEGqF
	J2ezXVxCtezZd0SgIxVVtJFMVYPYhEn+TH+iw2nDuZ5zdRJXE6syR9pFcbIYNj29fJOWlPFxpL/bI
	nQfhEBA/Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1rs7-00034E-H2; Tue, 19 Jan 2021 14:20:39 +0000
Received: from hqnvemgate25.nvidia.com ([216.228.121.64])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1rs2-00033g-Pv
 for linux-nvme@lists.infradead.org; Tue, 19 Jan 2021 14:20:36 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6006eaaf0000>; Tue, 19 Jan 2021 06:20:31 -0800
Received: from [172.27.15.147] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Jan
 2021 14:20:28 +0000
Subject: Re: [PATCH 1/1] nvme: update enumerations for status codes
To: Christoph Hellwig <hch@lst.de>
References: <20210104125947.160984-1-mgurtovoy@nvidia.com>
 <20210114175208.GA31438@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <a09653f8-1cdd-c62c-6eb6-b0a114b581a1@nvidia.com>
Date: Tue, 19 Jan 2021 16:20:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210114175208.GA31438@lst.de>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611066031; bh=//mFHivwd9b6ouD7c9zBxVgAQUc0HDL+Ks+W+Vp9FWA=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=Z3aza1fZZIDK+lhCY8892ekJ/0aV7oqTnI/24tEkdRsUiqGJXIY4mF17NYb3pkUQ1
 hUM7dN2OAC0sw+GUj4ybun0SHZ3IlWKgXKPBzlvYPhkRbwVs9hKX91XIyDSwA53gYv
 OCMHl6a8ZvM9Dp05aCA0MTPvELQQrM0lv2udQfiqZThpUMMpVe6UgWGn6Fv9/Wz8If
 7r21uCSdCq4MBwn5nB6jyaQZDUMyp4kwlzJhjMlFMm/YPpKXuhGtrU0iDsn31jfqHb
 4bvOZ9P3/WNWF/vZy2xYpl/Sxh4NWfeBqQ+16Ph4o1YUzCzUI1hoGQ8cbJ8SqNYyqG
 MXy3YB6Lsaeug==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210119_092034_907390_AB8B0645 
X-CRM114-Status: GOOD (  10.26  )
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
Cc: sagi@grimberg.me, chaitanya.kulkarni@wdc.com, israelr@nvidia.com,
 linux-nvme@lists.infradead.org, nitzanc@nvidia.com, kbusch@kernel.org,
 oren@nvidia.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 1/14/2021 7:52 PM, Christoph Hellwig wrote:
> Can we use this as a chance to resync with nvme-cli and have one
> version of the header that works for both?

Did you mean that both nvme-cli nvme.h files will be completely the same ?

nvme.h in nvme-cli has some weird cpu_to_le and le_to_cpu stuff and others..


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
