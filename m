Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB32C7619A
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 11:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=arz5KOhiDUN5hok7K06HkF+rvhv+89nduKaWgnCKULI=; b=DAJ60ICjAn6PxQ
	bpgWvxQbNCJ3UBOMi6nQfWHurdZVAy6yLt66tPci8Mw7fiAC8SHIsXv7l7owTAZilInDReR5Kq/+F
	L7LE7qbT1Ua7v61kR+tCdevOqSQ3PQ1KGqfP285tSD3QG0DvRynLkUr5g9fNtq7oomta1i+UcNnJh
	jVPe7uPnmsyhdZ0AYGX3E5h5iIzC+YcP8tYlGuTLwo0x1TEFxpYZDZ+9Bz26JQg2x8TD2QcjiZXm7
	5An132CViEEVIQIEoQpkBt/DqKwHe1/M3TunlWVRwygLVgU6z7Q1VCBayazNJqCFkaNex+r7pbFel
	7mENOCghL1kodOIUf72A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgkiL-00Aiof-23;
	Mon, 27 Mar 2023 11:08:37 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgkiF-00Ailf-1t
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 11:08:35 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230327110824euoutp02c087f90828e2cc4dc810dde9a16bc427~QQhGMJQe30058000580euoutp02p
	for <linux-nvme@lists.infradead.org>; Mon, 27 Mar 2023 11:08:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230327110824euoutp02c087f90828e2cc4dc810dde9a16bc427~QQhGMJQe30058000580euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1679915304;
	bh=arz5KOhiDUN5hok7K06HkF+rvhv+89nduKaWgnCKULI=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=f1Al9GwkPKGSxo0qS2yt4x6PFTv5sfJAD5wsn5YOGbu66yNBm86j070iHp+dcvYEQ
	 x7XmzTCEotX8+6sdmPHHyzrVKu9tlv0nsoI5SgZTni70w87VKg71NHThW9cax6ECjK
	 RljwrHCtV3pnPj3q6WedoKZEgGwWbKVfTRSGVOa0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230327110823eucas1p2e864cfa3263a325d02107a05ad29e871~QQhF1h6HU1148311483eucas1p2r;
	Mon, 27 Mar 2023 11:08:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 19.77.10014.72971246; Mon, 27
	Mar 2023 12:08:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20230327110823eucas1p28a4d67908fa0c230403d0a79a640f611~QQhFXDNyQ1651716517eucas1p2V;
	Mon, 27 Mar 2023 11:08:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230327110823eusmtrp2c0d1ee0e353f8ef3fa43bbbcd42a1e8f~QQhFWd31t1419314193eusmtrp2Z;
	Mon, 27 Mar 2023 11:08:23 +0000 (GMT)
X-AuditID: cbfec7f5-b8bff7000000271e-58-64217927f17c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A3.78.09583.72971246; Mon, 27
	Mar 2023 12:08:23 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230327110823eusmtip183570ed48aeb000fb053430f9b7e3578~QQhFMrQVX3002830028eusmtip1N;
	Mon, 27 Mar 2023 11:08:23 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 27 Mar 2023 12:08:22 +0100
Message-ID: <a0fd8e90-54c6-9b5d-074b-9239a0d9caca@samsung.com>
Date: Mon, 27 Mar 2023 13:08:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
	Thunderbird/102.9.0
Subject: Re: [RFC v2 1/3] nvme: move fault injector to nvme-debugfs.c
Content-Language: en-US
To: Alan Adamson <alan.adamson@oracle.com>, <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20230323230316.2914077-2-alan.adamson@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djP87rqlYopBodeaVjs6T/FZLFy9VEm
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8Pj69xRLAGsVlk5Kak1mW
	WqRvl8CVsfLrI6aCKdwV69bPZG9gPM3RxcjJISFgIvFhQxtrFyMXh5DACkaJXbOns0E4Xxgl
	jr5fCuV8ZpR4eu8MG0zLsYlvmSASyxkl9u+9gFDVf/colLOTUeLDlgfsIC28AnYS8z7MZwWx
	WQRUJfafmM0EEReUODnzCQuILSoQJdF3exNYjbCAq8TEgwcYQWxmAXGJW0/mg9WLCPhIrL27
	gx0ibinx+VsTUA0HB5uAlkRjJ1iYU8Be4sbz/ywQJZoSrdt/Q5XLS2x/O4cZ4gNFiUk337NC
	2LUSp7bcAvtGQuANh8Tx3Y1QCReJxj+HoRqEJV4d38IOYctI/N8JcY+EQLXE0xu/mSGaW4C+
	37meDeQgCQFrib4zORA1jhJXpm1ghwjzSdx4KwhxD5/EpG3TmScwqs5CColZSD6eheSFWUhe
	WMDIsopRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMw6Zz+d/zrDsYVrz7qHWJk4mA8xCjB
	wawkwrvZWzFFiDclsbIqtSg/vqg0J7X4EKM0B4uSOK+27clkIYH0xJLU7NTUgtQimCwTB6dU
	A5PlTp1Ms+L9XVf4+6fd/3sj86W/X/i5L8mZBha8j9QsFKeUif9wfrzDkLGTk3nNvL9S5dM5
	1xxOu3poo/+km1rZxeZ9txWqMoO4Y7b/m23maTBbdkU9z+fXj5k5er71Kq/q7DTaJyl+UezY
	ofIbyfYnJB6vaEx+8Toy9vyzPWnn3NpMmcxv/au+qqS0QiPk2E+2kqyAP58vrZJbcc3l1fsj
	OudN/uw5N5H/LJd77NyC7Wwvq6LtN+Wsf3s13Gb/T1vuPGWfh+myPy4t/fFf68uO3cyOrLYT
	GZk0zK7mc2xUNf0uLn4n8Me3bK3iLKbVbkZeRurxa4w/HFA8YrzCiXlVyHruzJV1+xu+irxr
	KVBiKc5INNRiLipOBABkHP/UqQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7rqlYopBh2N3BZ7+k8xWaxcfZTJ
	YtKha4wW85c9ZbdY9/o9iwOrx/l7G1k8Nq3qZPPYvKTeY/fNBjaPj09vsQSwRunZFOWXlqQq
	ZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlrPz6iKlgCnfFuvUz
	2RsYT3N0MXJySAiYSByb+Japi5GLQ0hgKaPEr+YeNoiEjMSnKx/ZIWxhiT/Xutggij4ySjy7
	1coM4exklPh/YhJYB6+AncS8D/NZQWwWAVWJ/SdmM0HEBSVOznzCAmKLCkRJfD7QAjZVWMBV
	YuLBA4wgNrOAuMStJ/PB6kUEfCTW3t3BDhG3lPj8rYkRYtlxRonJa2cBDeLgYBPQkmjsBKvh
	FLCXuPH8PwtEvaZE6/bfUL3yEtvfzmGG+EBRYtLN96wQdq3E57/PGCcwis5Cct4sJGfMQjJq
	FpJRCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTG6rZjP7fsYFz56qPeIUYmDsZDjBIc
	zEoivJu9FVOEeFMSK6tSi/Lji0pzUosPMZoCw2gis5Rocj4wWeSVxBuaGZgamphZGphamhkr
	ifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTAp2ZnE8G7vtLuwKfKbxg7tnu9Vl9/b5PhusiqN
	tGVXCX/SbOBQKbmx4iuLbjevcfr5tMMibb7fp1xa+uD0xolPFvocLYtv8rrLtadz9sPP6acu
	Sweejz/VLeZjLqvvEd56VmJxgMnkjEMmEQu75eWCv4oomG45zfJwxdmlAo3cMisT1yl8tZL7
	Ju60MF/qm8JlqUlKHBdFWHg3rgu9azYvIj7P4OE1mYTse1F7H7LoaMl32wlqXmvqMpjm21C+
	do/q9R1eSbNOfSy0KFK8tcVSvcfQ4dKN1B1aVk07dGZZB3L9vFAQtHKl0NbuA3b61qq5az80
	1gTuD4lLFLKTs/nZ1qDtsj5WwP+k2mQBJZbijERDLeai4kQAs3VXjV4DAAA=
X-CMS-MailID: 20230327110823eucas1p28a4d67908fa0c230403d0a79a640f611
X-Msg-Generator: CA
X-RootMTR: 20230323230622eucas1p2ede700e9ca703649ef44d7912b4b1470
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230323230622eucas1p2ede700e9ca703649ef44d7912b4b1470
References: <20230323230316.2914077-1-alan.adamson@oracle.com>
	<CGME20230323230622eucas1p2ede700e9ca703649ef44d7912b4b1470@eucas1p2.samsung.com>
	<20230323230316.2914077-2-alan.adamson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_040832_233127_5F0D42F3 
X-CRM114-Status: GOOD (  17.55  )
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

Could we still retain the fault_inject.c code to avoid #ifdef for the fault_inject
code in debugfs.c?

We have two options:
- We could have both fault_inject.c and nvme-debugfs.c. Move the fault inject code from
nvme-debugfs.c to fault_inject.c so that we get rid of #ifdefs from nvme-debugfs.c.

- As the code for nvme-debugfs.c itself is not a lot (just 3 small functions including the next
patch) apart from the fault_inject code, we could move them to the header with the appropriate
#ifdefs and conditionally link the fault_inject.c code as before.

Let me know what you think.

--
Pankaj

On 2023-03-24 00:03, Alan Adamson wrote:
> Move the nvme fault injector code associated with debugfs into
> nvme-debugfs.c (new file) so all nvme debugfs associated can
> reside in a common place.
> 
> CONFIG_NVME_FAULT_INJECTION_DEBUG_FS needs to be enabled to
> be able to use fault injection.
> 
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> ---
>  drivers/nvme/host/Kconfig                     |  6 ++
>  drivers/nvme/host/Makefile                    |  2 +-
>  drivers/nvme/host/core.c                      | 11 ++--
>  .../host/{fault_inject.c => nvme-debugfs.c}   | 56 +++++++++----------
>  drivers/nvme/host/nvme.h                      | 31 +++++-----
>  5 files changed, 59 insertions(+), 47 deletions(-)
>  rename drivers/nvme/host/{fault_inject.c => nvme-debugfs.c} (60%)
> 

