Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E319E7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 07:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QxBz4I5Bd8yWJ2kULw7TmX5U/VJ7rww++l23i4gpHzo=; b=v27KeUGkynjyx1nIi5BxqtiGaS
	wqrQY6UDIi6cNL+Qt78Il6fm9C8avPI3aaSGWvK5OOXyCxW/9uhLbQo5tHwoRhWGAdkg2LM9R6GBx
	EbKQCS98rC4NKGx50sysZ62vI+PgYCq28TaqUDpt3MqM+XI8E8GcHVO4DA4k0XPN+fq2aMjKiidsp
	NF3xqpTVCUW7KDHK3C7zazuz2U7Bsym/EoXfyzX+JmeQdSiqD3np3PlrGhwKubdNaSCi3grsNN2At
	Blr0i5pRNfPhoFkWsW2cnTDtxF5PvoohKgmPnV+wTQYlP29CEj+EZin4xoEPBNiduOPFZpE1ZCJus
	LaA++YZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKv8O-0000000Acvj-3OUQ;
	Tue, 10 Dec 2024 07:58:20 +0000
Received: from [203.254.224.24] (helo=mailout1.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKv8J-0000000AcrY-22e3
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 07:58:19 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241210075808epoutp01d56b64d90a2d1e29c9d306210959a90d~PwdHVmR_I0453204532epoutp01b
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 07:58:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241210075808epoutp01d56b64d90a2d1e29c9d306210959a90d~PwdHVmR_I0453204532epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733817488;
	bh=QxBz4I5Bd8yWJ2kULw7TmX5U/VJ7rww++l23i4gpHzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aZh/96Uuht6nSe0ISywMQATQj5JwCVljoUsVK/+IDcpxayPuqCP0RQeET3FBrXiaj
	 idzrqMY0Hey95LCtf1ukS5uch8Bv2pDn8NYBK40eXqnA2kNv3H0US5p0zbVlMBhZrf
	 6L+5RT231zp7EGPHsAaNQupWhd5jsLQEnI030+fE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241210075808epcas5p44d08286581c4f706349efc99603f17bf~PwdHAPseg1109211092epcas5p4D;
	Tue, 10 Dec 2024 07:58:08 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y6rgy2H8Xz4x9Q3; Tue, 10 Dec
	2024 07:58:06 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	64.AA.19956.E84F7576; Tue, 10 Dec 2024 16:58:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241210073523epcas5p149482220b87ff3926fb8864ff1660e0c~PwJPv5MQY1662116621epcas5p1C;
	Tue, 10 Dec 2024 07:35:23 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241210073523epsmtrp2d39c52502af4e68a701f215ac25204ff~PwJPqPHvd2642626426epsmtrp2m;
	Tue, 10 Dec 2024 07:35:23 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-1f-6757f48e11bc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	A2.C8.33707.A3FE7576; Tue, 10 Dec 2024 16:35:22 +0900 (KST)
Received: from ubuntu (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241210073521epsmtip1d748fa8397b43956ed6c747819394c4f~PwJNzhOrs0603006030epsmtip1X;
	Tue, 10 Dec 2024 07:35:20 +0000 (GMT)
Date: Tue, 10 Dec 2024 12:57:27 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv12 12/12] nvme: use fdp streams if write stream is
 provided
Message-ID: <20241210072727.ehcfor5lifk4klrf@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20241206221801.790690-13-kbusch@meta.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmhm7fl/B0g62/eCyaJvxltpizahuj
	xeq7/WwWK1cfZbJ413qOxeLo/7dsFpMOXWO0OHN1IYvF3lvaFnv2nmSxmL/sKbvFutfvWRx4
	PHbOusvucf7eRhaPy2dLPTat6mTz2Lyk3mP3zQY2j3MXKzz6tqxi9Pi8SS6AMyrbJiM1MSW1
	SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoXiWFssScUqBQQGJx
	sZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsax/nOsBVdZ
	Ks5ff83awDiRpYuRk0NCwETiws2fTF2MXBxCArsZJRZd3McM4XxilNh/t48FzmnY0cEI0/Lm
	Vg8jRGIno8TZh5vZIJwnjBL9F7cDDePgYBFQlTg+PQLEZBPQljj9nwOkV0RAUeI8MCRAypkF
	JjJJ/D7UxA6SEBYIlNjT+5ENxOYFWjCt8SkzhC0ocXLmE7BbOQXMJXZt+8sO0iwhsJRDYvmN
	o8wQF7lIHJvSwARhC0u8Or6FHcKWkvj8bi8bhF0usXLKCjaI5hZGiVnXZ0G9Yy/ReqofbBCz
	QIbEyq0PoYbKSkw9tY4JIs4n0fv7CdQCXokd82BsZYk16xdALZCUuPa9Ecr2kNi2tJsVEirb
	GCX2/PrGOIFRbhaSj2Yh2QdhW0l0fmhinQUMMWYBaYnl/zggTE2J9bv0FzCyrmKUTC0ozk1P
	LTYtMM5LLYdHc3J+7iZGcCLW8t7B+OjBB71DjEwcjIcYJTiYlUR4ObxD04V4UxIrq1KL8uOL
	SnNSiw8xmgIjaCKzlGhyPjAX5JXEG5pYGpiYmZmZWBqbGSqJ875unZsiJJCeWJKanZpakFoE
	08fEwSnVwOR0/KbN6Z8pm2Wtr8w6Nn1rxV8h/z/CWfI7thxj3/IumOkB766Vei/8bocf8nmX
	++jw0jdPOvfPMJ6wWOrvY+0rG+NnOd66NN/s6v3Pe6eKcc48d+NLZ6pAmaDgSg9xjhTmyZP8
	HURk975aa/jnb9Sd6AKZU+37BbRzzl5l/2HmeHOCkoCcig9bPv92gRtipwOvssQaFsiddPRl
	DmDIW/mggLE6s1x+/vQfLCH/dN6o2/yXUZlYfFBjxfrb+WUlvzN3njQVS159Qz7EUGiN+zH3
	VyuaxV8FOV148Enu7NsPzLb+pXeMb9opXOKaaB2VuC6h8OiTIK5y5uOlogE5z1luBq6cJp62
	2K8mbcO+d3JKLMUZiYZazEXFiQD/ivsNTQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSnK7V+/B0g8sLLS2aJvxltpizahuj
	xeq7/WwWK1cfZbJ413qOxeLo/7dsFpMOXWO0OHN1IYvF3lvaFnv2nmSxmL/sKbvFutfvWRx4
	PHbOusvucf7eRhaPy2dLPTat6mTz2Lyk3mP3zQY2j3MXKzz6tqxi9Pi8SS6AM4rLJiU1J7Ms
	tUjfLoEr49rX86wF7UwVN3ZtZW5gvMvYxcjJISFgIvHmVg+QzcUhJLCdUWLO/wVMEAlJiWV/
	jzBD2MISK/89Z4coesQo0b9rAlARBweLgKrE8ekRICabgLbE6f8cIOUiAooS54GuASlnFpjM
	JPF85jEWkISwQKDEnt6PbCA2L9DiaY1PmUF6hQSSJF5+N4cIC0qcnPkErJxZwExi3uaHYCXM
	AtISy/+BjecUMJfYte0v+wRGgVlIOmYh6ZiF0LGAkXkVo2hqQXFuem5ygaFecWJucWleul5y
	fu4mRnDEaAXtYFy2/q/eIUYmDsZDjBIczEoivBzeoelCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
	eZVzOlOEBNITS1KzU1MLUotgskwcnFINTKFifiwXBI+JfdRhlM7/aLpgkekctRvuykfPXz1x
	5A/LuwUsp1amGN2TWHY0u/hszizOWbZzFWR+tjzZVn3nGMOM8K7FwZM+s72r2bngnbSXsP3x
	iHN/2ZNiMpgWP5DdrapsninGm9k+f7d5QcnKOTnWc8SDp3QWTMoRXmnvlHHO8Ea7yfHf6Tq6
	fqe3FB+dKnZe9nFty9orKv4dNw1lngoa/9ONCJ/Ye6i8Lu5I2JG0ntXRJ2f9Wnx63ZOnKUtn
	tRwPZfZI4Jqy4ePe/LiXjorbN2yU374jzeCDwHl7ve+NB2NfxnpI71uv8q1t5Zzmc6fv7ZP7
	dIXfsbwj7dvr/QemtfhdC5gt78W2O66+47QSS3FGoqEWc1FxIgBVHUL6BwMAAA==
X-CMS-MailID: 20241210073523epcas5p149482220b87ff3926fb8864ff1660e0c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----OTMyRIxA-vjvkyMBIEVTa8B.hsA2RhXFaIa_oKBleWSyrD67=_710e1_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241210073523epcas5p149482220b87ff3926fb8864ff1660e0c
References: <20241206221801.790690-1-kbusch@meta.com>
	<20241206221801.790690-13-kbusch@meta.com>
	<CGME20241210073523epcas5p149482220b87ff3926fb8864ff1660e0c@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_235815_858049_EB4CE5EC 
X-CRM114-Status: UNSURE (   9.19  )
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

------OTMyRIxA-vjvkyMBIEVTa8B.hsA2RhXFaIa_oKBleWSyrD67=_710e1_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 06/12/24 02:18PM, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>Maps a user requested write stream to an FDP placement ID if possible.
>
>Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------OTMyRIxA-vjvkyMBIEVTa8B.hsA2RhXFaIa_oKBleWSyrD67=_710e1_
Content-Type: text/plain; charset="utf-8"


------OTMyRIxA-vjvkyMBIEVTa8B.hsA2RhXFaIa_oKBleWSyrD67=_710e1_--

