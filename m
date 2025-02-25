Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C97C021A4
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 01:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yt7FV8Is/XZOi8N7ebx2gw+ZNuxX/nMnNKn9hf0ikMI=; b=q5mjCuD4xbeRLpBDH90TnvZ9dA
	rhuyQe3KFviN06LujxO6GoiXmr0YmMCIOH/ITbpPTRFWxV0jLr3QZ776YEMLfxnpIouWG6Yq3MVsY
	+KQd5JfPPG2s0Pm5Pk4Qte89FfCp1OS5spteN8nJCOf1tR9W+231sMCfvsLjraKeQpEqfChSsludi
	Gok6Y8YJ3Yc7+26oN7EUYo0T34sOJnWw8qqf3LCp+8jpZy3Z2o7VehDQRgp3GALFd3ZuA961JI4Ob
	PJD65XeAGaqUROw41eWydOF2NsAToN+QmoeBfk5YCleTF1OuA7zpQYZlg6vpO8LOqrcCubw0rYxzf
	r9pE+49g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmk76-0000000FjzY-3tp2;
	Tue, 25 Feb 2025 01:52:00 +0000
Received: from omta034.useast.a.cloudfilter.net ([44.202.169.33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmk6j-0000000Fjtb-32sR
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 01:51:38 +0000
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id mblHtDl4eXshwmk6XtdcbZ; Tue, 25 Feb 2025 01:51:25 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id mk6VtijhO6Lcjmk6VtiY2L; Tue, 25 Feb 2025 01:51:24 +0000
X-Authority-Analysis: v=2.4 cv=UfxXSrSN c=1 sm=1 tr=0 ts=67bd221c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=6Vi/Wpy7sgpXGMLew8oZcg==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7T7KSl7uo7wA:10
 a=oltRCMenW_0Ea9-Xwq4A:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Yt7FV8Is/XZOi8N7ebx2gw+ZNuxX/nMnNKn9hf0ikMI=; b=FAlNsKkUoIJYZiQd1fuXC5EcHn
	RvU4cr7cQwvw2jO60pbhr3XUqC8oJo4oagWZczJ4Mrhuytki65/XzuhYs+2iHsC2cap1CBRhRS44Z
	5pk5CO4hRWNavWIdLB5zKgkYJLXNgsNl3r/To1FSkpr+/+9kz+2GCniwZQRGRfmgkS+Y5SHFvphB3
	jO46v03XIDm9N5m9OVSij54DbuaANzHIIke9eiIdHKlRD7nnWxUj7HmWRFbcP4uANnaCdwqeLVqtT
	3NoR6ligc3UErUhqO8Pj2n+Cv4xSWKNMUg/2D67jE/w+NdVG+Oz590fxQkO2QcbqbvjZPzYi/aGUw
	spKgTMVw==;
Received: from [45.124.203.140] (port=53629 helo=[192.168.0.158])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tmk6U-001k4Y-2S;
	Mon, 24 Feb 2025 19:51:23 -0600
Message-ID: <c3c28d70-540b-4034-8a89-8a6c4dcf17ab@embeddedor.com>
Date: Tue, 25 Feb 2025 12:21:15 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8][next] nvme: target: Avoid
 -Wflex-array-member-not-at-end warnings
To: Christoph Hellwig <hch@lst.de>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <cover.1739957534.git.gustavoars@kernel.org>
 <ef7a6920384ab2f8f83c0f630f94edc73cd65997.1739957534.git.gustavoars@kernel.org>
 <20250224141938.GB1088@lst.de>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250224141938.GB1088@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 45.124.203.140
X-Source-L: No
X-Exim-ID: 1tmk6U-001k4Y-2S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.158]) [45.124.203.140]:53629
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPq2aF13ox1QQKt4ephE2wp5s1Pw037Sv8f77WqyQyczTQfakFSDNWCQgLoIcbzAlyDXJnURJY9lUBHbtJzQO/zOwOCJOXJMX16pfnaD50Y2FIj1+ZN3
 XMGvZgJp1fujZtz2Eybsg8eeJ0C3JI/NoTHWt8qwbAt5Kz0GmmG3JZMD6+HFpCunmlk3F8EwG2DNQBDN2dI83HFsvqYiyRrIcVGDuxdwSW21wql0KoiruyIy
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_175137_887051_8569DB6D 
X-CRM114-Status: GOOD (  11.81  )
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



On 25/02/25 00:49, Christoph Hellwig wrote:
> On Mon, Feb 24, 2025 at 08:30:10PM +1030, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Change the type of the middle struct members currently causing trouble
>> from `struct bio` to `struct bio_hdr`.
>>
>> We also use `container_of()` whenever we need to retrieve a pointer to
>> the flexible structure `struct bio`, through which we can access the
>> flexible-array member in it, if necessary.
>>
>> With these changes fix 38 of the following warnings:
>>
>> drivers/nvme/target/nvmet.h:455:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>> drivers/nvme/target/nvmet.h:462:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
> 
> I'm not sure where you bio_hdr structure comes from, but maybe that's
> because you annoyingly split CC over the series, and by the number of
> patches probably also bundled unrelated changes.

Ugh, yes, I messed up my script just before creating the series.

> 
> In general our first resort here should be to move embedded bio to the
> of containing structures.  If that's not possible you'll need to explain
> why.
> 

Yes. Also, thanks for the feedback in your other response. I'll try to
follow that approach and see how it goes.

--
Gustavo

