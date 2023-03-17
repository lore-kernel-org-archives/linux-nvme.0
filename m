Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C405DC6FD1D
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Mar 2023 09:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QNzbSfpKVwLAePf2se78JJ99lVJ48Dy9r9Nfj2T8Hmw=; b=MrEsDGaY6bSIYv+xeLZ/krfMtJ
	vaItMqurm0tW/NOReDP6hiFkxGhGCLpmgXGeASwlaMwiTZcS9cGCA3B9GUyi+cHy0Ctt9nJ4vqOSP
	mg2zP2HWeDhRRkGaNP7q24Qw4WPzQth2D5bGFXV1Xr8GH/K1EkqS/ONZ6g4a/BzQu7AY8vp9Ii7VP
	cVckeZ6Xa10OFPSgFkM/qdc9yqpNvPP10URgnbXG5rd5DDm7aVXJzmktCn+vbOdenIWQc4GPXVf28
	GyOIOeJ0YMoyABlS2+XNlYTVESYhynDrPnYL3KdHgXvNTJE66pkmMWWJQVcwhOUAOi91LI6IgqtJq
	cDPE7vNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pd5xm-001d8X-2j;
	Fri, 17 Mar 2023 09:01:26 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pd5xj-001d31-0s
	for linux-nvme@lists.infradead.org;
	Fri, 17 Mar 2023 09:01:25 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230317090115euoutp01df84b7e16c8d9eb8a7f5cc1e765470c5~NKVOZY1jk2376923769euoutp01T
	for <linux-nvme@lists.infradead.org>; Fri, 17 Mar 2023 09:01:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230317090115euoutp01df84b7e16c8d9eb8a7f5cc1e765470c5~NKVOZY1jk2376923769euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1679043675;
	bh=QNzbSfpKVwLAePf2se78JJ99lVJ48Dy9r9Nfj2T8Hmw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=lJ/Cg7HKIrCtQ0DLPNewsNAm4xwZK/xhdHca+o+5kMRnEGewJRp/gS+QqGnWOF/KJ
	 toKgsWOLskcgKFKB872OXVw0muLZnilgbxUgNL4nNHWVuPhy2O/B1Dyk9xlJGvXXJ9
	 HTNiMGAxddIkbVghx+IYLeOEB2zuTh9RxnAY6qzM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230317090115eucas1p1c3014b50958d95ce5fb38bb19d520467~NKVOTTQ_B0752507525eucas1p1K;
	Fri, 17 Mar 2023 09:01:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id A0.6E.09503.A5C24146; Fri, 17
	Mar 2023 09:01:14 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230317090114eucas1p11073fbdbca45d20600789ec121d4470e~NKVN4Q0Wj0549305493eucas1p1W;
	Fri, 17 Mar 2023 09:01:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230317090114eusmtrp18cb0cc7d28b70d56816de43a5d2dd3eb~NKVN3upqu2988829888eusmtrp1N;
	Fri, 17 Mar 2023 09:01:14 +0000 (GMT)
X-AuditID: cbfec7f2-ea5ff7000000251f-9f-64142c5aab7e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 28.59.08862.A5C24146; Fri, 17
	Mar 2023 09:01:14 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230317090114eusmtip2357b406499c438fa34b38ce6d15e0bd0~NKVNup4S91501915019eusmtip2d;
	Fri, 17 Mar 2023 09:01:14 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 17 Mar 2023 09:01:13 +0000
Date: Fri, 17 Mar 2023 09:52:57 +0100
From: Pankaj Raghav <p.raghav@samsung.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>, <hch@lst.de>,
	<sagi@grimberg.me>
Subject: Re: [RFC 2/2] nvme: add error logging opt-in
Message-ID: <20230317085257.thj7cwhg6cip26gt@blixen>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230316234958.1486700-3-alan.adamson@oracle.com>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduzned0oHZEUgz9/zSz29J9isli5+iiT
	xaRD1xgt5i97ym6x7vV7FgdWj/P3NrJ4bFrVyeaxeUm9x+6bDWweH5/eYglgjeKySUnNySxL
	LdK3S+DKWPn2IXtBK3vFuq9/WBsY/7B2MXJySAiYSPyZs5+xi5GLQ0hgBaPEh2ebmSGcL4wS
	ff/eQTmfGSW+Pp3PDtPy/do8NojEckaJz08eMcFVdW54xALhbGGU6Jp+gAWkhUVAVeLsv1tA
	Wzg42AS0JBo7wSaJAJlX/uxiBrGZBWIlDr6ZDmYLC5hKTGo9zwJSzgu0rW1qLEiYV0BQ4uTM
	JywQ5ToSC3Z/YgMpYRaQllj+jwPE5BSwl3h6ow7iTCWJhs1nWCDsWom9zQfYQQ6TELjCIfH5
	wG6o910kvv7cyQxhC0u8Or4F6kcZidOTe6Caq4Fm/maGaG5hlOjfuR5sr4SAtUTfmRyIGkeJ
	ecf+M0GE+SRuvBWEuJJPYtI2kKdAwrwSHW1CENVqEjuatjJOYFSeheSvWUj+moXw1wJG5lWM
	4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBKeX0v+OfdjDOffVR7xAjEwfjIUYJDmYlEV7e
	n8IpQrwpiZVVqUX58UWlOanFhxilOViUxHm1bU8mCwmkJ5akZqemFqQWwWSZODilGpim7NBo
	nPK4Wt+rTuGjqt/HnrOnDB36f0cHsdsuapvuayp4zL9rS4WRJPsW17B9dc+PqtwOVTlx3CiH
	Y8pmp79+P9cxa8gx+v3LdTy2+tvxI4vnFEvOOcS+SO/BvNcJmravePzF+F4zKf1UdvX5H+7s
	VFO4Jflk0pXGWxw2mr3fT32RSq3MqE1b9K313gdnZUtnhsPMstY5FbkCM3e/nLZhF0d9cPPf
	vs+ilxSFKsKmMgRY2tueCZpivtz+i4vlyX9/JlszeG3nNzE9zf0nl9UlbHE8rxn3yYJ9Oet+
	Vxx+/PutjHjhnP1MdXvtxKXEN9lsVudjrfMv0NqzkzljbkHAfkmTdAUDgeaL/hsqlFiKMxIN
	tZiLihMByYxh4pgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7pROiIpBpsuylns6T/FZLFy9VEm
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8Pj69xRLAGqVnU5RfWpKq
	kJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXsfLtQ/aCVvaKdV//
	sDYw/mHtYuTkkBAwkfh+bR5bFyMXh5DAUkaJn5tnQSVkJD5d+cgOYQtL/LnWBVX0kVFi48Eb
	zBDOFkaJRTMXsYFUsQioSpz9d4uxi5GDg01AS6KxE6xZBMi88mcXM4jNLBArcfDNdDBbWMBU
	YlLreRaQcl6gK9qmxoKEhQSKJSY828QEYvMKCEqcnPmEBaJVR2LB7k9sIOXMAtISy/9xgJic
	AvYST2/UQVypJNGw+QwLhF0r0fnqNNsERuFZSAbNQjJoFsKgBYzMqxhFUkuLc9Nziw31ihNz
	i0vz0vWS83M3MQIja9uxn5t3MM579VHvECMTB+MhRgkOZiURXt6fwilCvCmJlVWpRfnxRaU5
	qcWHGE2BwTCRWUo0OR8Y23kl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1M
	HJxSDUyFx78ZnQl+xnOaRTesTyvmQWXCI+8pf/4qvQp+zeS0NehA1+KA7m2LLk5etZeT/8A8
	3tfVLxuC2yUsJ1/jef7Ca+4DG1GTM+q5tvE3fpx02Cx/94CibYbdBGXfvjkLXmRa5fX2zfdm
	N3rEWMHsyXk6w055/eSc5SqvVdZclmBQai69+rKkrVKyOLZSO7p/xfLLm96ZXn+3mPmIba65
	QrZON0v5hnQB29XrJsza2hu1Vf5MZO57Ec+dd40/5UhtFzY/9LUi7cOmhmvRm5jffnQWkQy4
	tEeze/t5xeMXNb932KqZh+wsto/8YRdV6u179on+xfsXJIXZt2yZoupsmem64NNSlqOiu04/
	Z2NzNlBiKc5INNRiLipOBAC5JCfpNQMAAA==
X-CMS-MailID: 20230317090114eucas1p11073fbdbca45d20600789ec121d4470e
X-Msg-Generator: CA
X-RootMTR: 20230317090114eucas1p11073fbdbca45d20600789ec121d4470e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230317090114eucas1p11073fbdbca45d20600789ec121d4470e
References: <20230316234958.1486700-1-alan.adamson@oracle.com>
	<20230316234958.1486700-3-alan.adamson@oracle.com>
	<CGME20230317090114eucas1p11073fbdbca45d20600789ec121d4470e@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230317_020123_904350_DFB1951C 
X-CRM114-Status: GOOD (  10.09  )
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

On Thu, Mar 16, 2023 at 04:49:58PM -0700, Alan Adamson wrote:
>  
> @@ -5183,6 +5188,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>  
>  	nvme_debugfs_init(&ctrl->debugfs, dev_name(ctrl->device));
>  	nvme_fault_inject_init(&ctrl->debugfs);
> +
> +	ctrl->debugfs.error_logging = false;
Can we wrap the above statement into nvme_error_logging_init function?
static inline void nvme_error_logging_init(struct nvme_debugfs *debugfs)
{
	debugfs->error_logging = false;
}
> +	nvme_error_logging_init(&ctrl->debugfs);
> +
>  	nvme_mpath_init_ctrl(ctrl);
>  	ret = nvme_auth_init_ctrl(ctrl);
>  	if (ret)
> +#ifdef CONFIG_NVME_ERROR_LOGGING_DEBUG_FS
> +void nvme_error_logging_init(struct nvme_debugfs *debugfs);
> +#else
> +static inline void nvme_error_logging_init(struct nvme_debugfs *debugfs)
> +{
> +}
> +#endif /* CONFIG_NVME_ERROR_LOGGING_DEBUG_FS */

