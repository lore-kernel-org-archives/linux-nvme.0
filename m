Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975E6C56203
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 14:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=VQL0CU65e4iEA3pvvKwc90Gi3q
	QS8azCNa9p+3D1XtSfqy6pNxx73+xKilbtT5JczG7TWAv7njBkKk2VrIDX0KOnK8tm8v6JwCLiesc
	0J+LXqihvwgWXYSWbUnhCAs/Lsz//FNjVIumonjIHrdDZSXDE1qPA78qviEeOli2XRnG3t+V5LebU
	lF+EszP8tKO/MHRNK+YqtO5U0A4d+F85ZpHUSrOm/hKQQtjPq92pINEEHNPRU1+r3e9h6LWb91XEE
	Uj19xjlXYysheAyrnv55UNqhtmeuVqFMAliHsKYDqqJh/GD6i0Ulg6K3p638Fc+JlQhhneBIkjdXT
	FKToAy3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtRYq-0000000Eprm-3lMm;
	Fri, 20 Feb 2026 14:32:52 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtRYn-0000000Epnx-3K0k
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 14:32:51 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260220143238epoutp0469533eb728659e57ce92f4f24cf6aa5c~V_vUHFsJg2960529605epoutp04W
	for <linux-nvme@lists.infradead.org>; Fri, 20 Feb 2026 14:32:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260220143238epoutp0469533eb728659e57ce92f4f24cf6aa5c~V_vUHFsJg2960529605epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1771597958;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Y+6sX1UVEGppiBox34YExXnxX7L3z+PYJ3h4gV0toSnFbyLz493wLQANe6uRpyPA7
	 BDS7JC++v6+jh4JB2IAx6QdLpY0BqaLrmR+1Snv8hyZzWsmThJgtX5aFRsV1oBaoE7
	 h8CKK6lr+Mb/n5Hy91gBDB3Es3VYKwlBICNZcHro=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260220143238epcas5p44aaad8d33d1c301fe9f53269bfe7a354~V_vT6QZC80389803898epcas5p4i;
	Fri, 20 Feb 2026 14:32:38 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.86]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fHXlV0lT4z2SSKX; Fri, 20 Feb
	2026 14:32:38 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260220143237epcas5p48692d42bb58ddf61b4a7be0873fdab3b~V_vTKgODF0388603886epcas5p4v;
	Fri, 20 Feb 2026 14:32:37 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260220143236epsmtip1e6a6a37de340f5df06b2a482be967d44~V_vSbZ78S2547425474epsmtip1I;
	Fri, 20 Feb 2026 14:32:36 +0000 (GMT)
Message-ID: <425f828d-ddf6-4215-b72d-143e37b74851@samsung.com>
Date: Fri, 20 Feb 2026 20:02:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-core: do not pass empty queue_limits to
 blk_mq_alloc_queue()
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260220133016.524192-1-mlombard@redhat.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260220143237epcas5p48692d42bb58ddf61b4a7be0873fdab3b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260220133056epcas5p1f981cf74d0f768d1251fdcac73fbca5f
References: <CGME20260220133056epcas5p1f981cf74d0f768d1251fdcac73fbca5f@epcas5p1.samsung.com>
	<20260220133016.524192-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_063250_318279_7C538324 
X-CRM114-Status: UNSURE (   5.47  )
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

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

