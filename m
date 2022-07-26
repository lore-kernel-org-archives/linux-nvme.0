Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8C3C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jul 2022 02:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lZ8FUj7VxHaPBlapzv9l6Yu5BbwVpf+W5aCEEMGy+k4=; b=LrUEu123BLbjMiFz6AXTNdo5b+
	baQFmOJW83Hn+kxZWJkDmUP2ow2XFbjaUIHv2bA9vTSNLy8+ApfCXg+96oifR7wec3elyh0Az3ZJV
	tPTSoe8/rxRNACWbTY7ppJbB8IBqH1CYWiXd9Z2eQzl0bY9tRSb6rPDC6+1nEguAT/f3Bq/1mh+qe
	z/tvGeC5OQv+67oOTYJG4nhR3CIw7ERcVkR+vENttSo3IzloZBSEczXQOWeqlMrXVxO6kKQFiuSkR
	YJ/Wki2R9ukPmdWjsegWascA2rtCMiUarMkPXUQyR/+77c1EiZ1aMM9cs3IMgEDTC3/cN0B4KFY+3
	R7YkrHxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGA3B-006oVZ-QG; Tue, 26 Jul 2022 02:11:57 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGA38-006oT6-DM
	for linux-nvme@lists.infradead.org; Tue, 26 Jul 2022 02:11:56 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LsL3Y4KrDz9sqH
	for <linux-nvme@lists.infradead.org>; Tue, 26 Jul 2022 10:10:33 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 10:11:42 +0800
Subject: Re: [PATCH v2] nvme: consider also host_iface when checking ip
 options
To: Daniel Wagner <dwagner@suse.de>
CC: <linux-nvme@lists.infradead.org>
References: <20220722092456.24517-1-dwagner@suse.de>
 <3f0528a5-73d2-3dc5-32fb-0eb73797bf71@huawei.com>
 <20220722094648.i6w3dymag3mfjpuo@carbon>
 <ce2ba75a-3dd6-8530-c868-298bbeb93d67@huawei.com>
 <20220722100932.tyjljbccwv47tg4z@carbon>
 <a37fc589-b47b-61c6-0c36-c3b13e7ce56d@huawei.com>
 <20220725092522.i7lch2p4tn7uj6ii@carbon.lan>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <37845bb2-c868-938b-8aed-cbc18594b9d6@huawei.com>
Date: Tue, 26 Jul 2022 10:11:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220725092522.i7lch2p4tn7uj6ii@carbon.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_191154_669321_CF5A8260 
X-CRM114-Status: GOOD (  11.06  )
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



On 2022/7/25 17:25, Daniel Wagner wrote:
> On Mon, Jul 25, 2022 at 08:52:27AM +0800, Chao Leng wrote:
>>> What's wrong with it?
>> nvme over tcp has implemented host_iface-related processing.
>> But nvme over rdma(roce) do not.
>> You can test with nvme over rdma(roce).
> 
> Ah, now I get your point. Indeed this will only work for the TCP
> transport. But the RDMA transport doesn't set the NVMF_OPT_HOST_IFACE to
> the allowed_opts so we should filter out this with the additional
> NVMF_OPT_HOST_IFACE checks for the RDMA transport.
Yes, adding opts->mask filter with NVMF_OPT_HOST_IFACE is correct.
  	if (!nvmf_ctlr_matches_baseopts(ctrl, opts) ||
  	    strcmp(opts->traddr, ctrl->opts->traddr) ||
  	    strcmp(opts->trsvcid, ctrl->opts->trsvcid) ||
-	    strcmp(opts->host_iface, ctrl->opts->host_iface))
+	    (((opts->mask & NVMF_OPT_HOST_IFACE) &&
+	      (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)) &&
+	       strcmp(opts->host_iface, ctrl->opts->host_iface)))
  		return false;
Checking host_iface is similar to host_tradr, so some suggestions:
First, move these codes near checking host_traddr.
Second, the checking logic should be the same as that of host_tradr.
It might be better to add a helper to implement host port attribute
checking. Of course, this can be considered as a separate patch.
> .
> 

