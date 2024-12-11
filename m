Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671BBE7717D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 08:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K2B9FWo5Kyw4Xk09+eswDesCTEDzuKTmCC+Cik8lONw=; b=Hndqxwu4Rw5js4TTXL+0s1f7H1
	Yz203cvWdL2Ut1seCmN774dcm/R73EmkR6Qt288DLLjnqCHIZknSCjRWIcUMbFHnLvavx6bGbt8Nr
	WEGAfgjPDHeSDnr4FE2vxsmivn1QzdCMaM9+AcRaUgO7wqPKdtqmqSH9Gg4UyxP9cjNdJjgRapadZ
	MpaOIGQLbG8nWvwoybkNzzNNR7wLY/eEUGFB8BOxeUTOe1SbKh7Bfv7Tc5kITKyLvD4daFYoCQwca
	dAHH1k9zOM9rPLbc18Jks+e93ZkkU7IUAJWognSZIPhnDhwm65QPX41xyapTaox0Q3ZxekIfiDrG1
	8eH+/4wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLHo3-0000000EAtU-2BP3;
	Wed, 11 Dec 2024 08:10:51 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLHnj-0000000EAkh-0Dg3
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 08:10:33 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241211081025epoutp0312b5965d62671d36eb905396d736d383~QERH5Im-60541005410epoutp035
	for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2024 08:10:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241211081025epoutp0312b5965d62671d36eb905396d736d383~QERH5Im-60541005410epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733904625;
	bh=K2B9FWo5Kyw4Xk09+eswDesCTEDzuKTmCC+Cik8lONw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p5Jtbx+Ff+7PQnvuTlMFv8/I8OQCPoIYV5ni/5MnmOzwUOxvA8gD5ziCvAOThJK4a
	 xwlMNFgpBGKPg+R59zzarOCFiAA8LmApvHUJivkR8jtMAIOxz3NKWYSobrfj2rm9Sn
	 UZUtCeOpdZ4gBaEb0ai2/tdbfGgjvT+VXtX4hZLs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241211081025epcas5p3b097c796c4b4194276a6ff920b06d465~QERHnMnD_2044020440epcas5p3Z;
	Wed, 11 Dec 2024 08:10:25 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Y7Svg64nyz4x9Pr; Wed, 11 Dec
	2024 08:10:23 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4E.41.19933.FE849576; Wed, 11 Dec 2024 17:10:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241211065235epcas5p2a233ac902da67bf2d755d21d98e6eb21~QDNKrEmW20963509635epcas5p2H;
	Wed, 11 Dec 2024 06:52:35 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241211065235epsmtrp256481e0528c23f12e2dc28f65ba885e6~QDNKqPjz_1000610006epsmtrp2M;
	Wed, 11 Dec 2024 06:52:35 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-31-675948ef0ca8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	0E.57.33707.3B639576; Wed, 11 Dec 2024 15:52:35 +0900 (KST)
Received: from ubuntu (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241211065233epsmtip2d07206f508fd76e0b66edc221deffb9b~QDNIuvIMr0342103421epsmtip2-;
	Wed, 11 Dec 2024 06:52:33 +0000 (GMT)
Date: Wed, 11 Dec 2024 12:14:40 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv13 06/11] io_uring: enable per-io write streams
Message-ID: <20241211064440.uscdxxydkbh7ddne@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20241210194722.1905732-7-kbusch@meta.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmpu57j8h0g8OT9SyaJvxltpizahuj
	xeq7/WwWexZNYrJYufook8W71nMsFkf/v2WzmHToGqPFmasLWSz23tK22LP3JIvF/GVP2S3W
	vX7P4sDrsXPWXXaP8/c2snhcPlvqsWlVJ5vH5iX1HrtvNrB5nLtY4dG3ZRWjx+bT1R6fN8kF
	cEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHa6k
	UJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0MDAyBSpM
	yM5Y9Xg5S8E51opNf9eyNTC+Zuli5OSQEDCROPP/JROILSSwm1Hi+DPhLkYuIPsTo0T728Xs
	cM6/JcvZYTqOP5/PDJHYySgxa8NdKOcJo8ST41vB5rIIqEqcff+LrYuRg4NNQFvi9H8OkLCI
	gKLEeWBogNQzC2xmkpizbwMrSEJYwFniYG8zmM0LtKH/+EZGCFtQ4uTMJywgczgFzCV+7pYG
	6ZUQ2MEhMX39ZqiLXCT2f+5jgrCFJV4d3wIVl5L4/G4vG4RdLrFyygo2iOYWoKuvz2KESNhL
	tJ7qZwaxmQUyJHrf/mWFiMtKTD21jgkizifR+/sJ1AJeiR3zYGxliTXrF0AtkJS49r0RyvaQ
	OH32LiMkVLYzSrw9dop5AqPcLCQPzUKyD8K2kuj80ARkcwDZ0hLL/3FAmJoS63fpL2BkXcUo
	mVpQnJueWmxaYJSXWg6P5eT83E2M4MSs5bWD8eGDD3qHGJk4GA8xSnAwK4nw3rCPTBfiTUms
	rEotyo8vKs1JLT7EaAqMoInMUqLJ+cDckFcSb2hiaWBiZmZmYmlsZqgkzvu6dW6KkEB6Yklq
	dmpqQWoRTB8TB6dUA1OY67YoxgM+r3Y8Nrxl3iJq2qMQc3StpVi3bfU7i77ASc5RMw7lqjlJ
	/hdzC9+21fmjZObyw+e2zXD+p5ezdqpb2wKFh7ed476+lDD51+swi3/Z7asJ8tmXpiSkWPy0
	2Ciz9cNkdiOP7vq1Ank7fjyY9Ke2UWdikw1r8TE/F3vhB0/PnHogl3znCLdNwAN9BR42U/2V
	MvN3qh01Z1WW41/YqbpNisnHUj0q77rwxMXf7s7fLbtk2Q2uNrfP+in/+H+27TOIdLoU4V9R
	5GazvfBMTnaj+93n+hL+iR/fnft7LqPofNMip/elvcd2T2ku53ji+1FF44hHmSzLBtMfzuE3
	ZG5vuTy5aWW4sKjaLSWW4oxEQy3mouJEANsEBh9VBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSvO5ms8h0gzfLxCyaJvxltpizahuj
	xeq7/WwWexZNYrJYufook8W71nMsFkf/v2WzmHToGqPFmasLWSz23tK22LP3JIvF/GVP2S3W
	vX7P4sDrsXPWXXaP8/c2snhcPlvqsWlVJ5vH5iX1HrtvNrB5nLtY4dG3ZRWjx+bT1R6fN8kF
	cEVx2aSk5mSWpRbp2yVwZUxdtZ6poIG54s7DzywNjNuZuhg5OSQETCSOP5/P3MXIxSEksJ1R
	ouPzbHaIhKTEsr9HmCFsYYmV/56zQxQ9YpSYfnM/WIJFQFXi7PtfbF2MHBxsAtoSp/9zgIRF
	BBQlzgOdBFLPLLCZSWL5hy4WkISwgLPEwd5mVhCbF2hz//GNjCC2kECyxN3ee0wQcUGJkzOf
	gNUzC5hJzNv8kBlkPrOAtMTyfxwgJqeAucTP3dITGAVmIWmYhaRhFkLDAkbmVYyiqQXFuem5
	yQWGesWJucWleel6yfm5mxjBUaQVtINx2fq/eocYmTgYDzFKcDArifByeIemC/GmJFZWpRbl
	xxeV5qQWH2KU5mBREudVzulMERJITyxJzU5NLUgtgskycXBKNTDpvFBK/vXkkRvDwjWsaU9f
	VvSqOJfviKxduyj1UfWJ8OaHy58EVO9y8ncuOO+6xPlm+kanTQ7nLDwuhtx8/NJQW+S3kn+f
	QHiCLIePxeWa4mvtW5x9hRbGrVZbVOpR1LhkZXz4gxB9o6l/N+xamJZTtHstd/+cSalzHgm/
	udSiyrmdfZ51F2eTyufF7/9oeFo4yFht7D/fLXYkRnpv0e8N9iGzuRY2TghcevWY3twfzBbP
	BB8/4am42Bdgofl0msB5qSr9bRb+a/QfOwROZD317Nlcdp+tP9Z6Nc9at+s7x1nTW29uXu69
	82rPq8PR7xlYzQ68/t350SzC08zj3G8N8RoZO5esVGmNP9qCivVKLMUZiYZazEXFiQD0Qlh1
	EQMAAA==
X-CMS-MailID: 20241211065235epcas5p2a233ac902da67bf2d755d21d98e6eb21
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----syFHuyivwrsgIW8y2bU-AmBmzS5V9dEENjkeRCLm2dEK6Ofb=_76639_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241211065235epcas5p2a233ac902da67bf2d755d21d98e6eb21
References: <20241210194722.1905732-1-kbusch@meta.com>
	<20241210194722.1905732-7-kbusch@meta.com>
	<CGME20241211065235epcas5p2a233ac902da67bf2d755d21d98e6eb21@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_001031_569123_B18F2347 
X-CRM114-Status: UNSURE (   9.40  )
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

------syFHuyivwrsgIW8y2bU-AmBmzS5V9dEENjkeRCLm2dEK6Ofb=_76639_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 10/12/24 11:47AM, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>Allow userspace to pass a per-I/O write stream in the SQE:
>
>      __u8 write_stream;
>
>The __u8 type matches the size the filesystems and block layer support.
>
>Application can query the supported values from the statx
s/statx/sysfs

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------syFHuyivwrsgIW8y2bU-AmBmzS5V9dEENjkeRCLm2dEK6Ofb=_76639_
Content-Type: text/plain; charset="utf-8"


------syFHuyivwrsgIW8y2bU-AmBmzS5V9dEENjkeRCLm2dEK6Ofb=_76639_--

