Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74841C25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 07:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jWCOeb8x4NIqcfn/S47RDrttegWDeSIWveRZexI/Bx0=; b=zKOT5cnX1Ntl7eS5c00xPKLay3
	wFwdVR9SCS6997usjFlkOvx/hQ1JD1E88PJAsOZenUaomeie7YdShwlTSRBKyq5FwmugSbc8a/2TG
	fObv5MovUhGZWo4lRM75+DcFZtkmLMtnUN07PQ6gNm1bObcpJzj3KZD9rGSUfg7TULHqvUxLOSZIe
	WAmXzkRYWMWBiPzbBBdUOY3Vr6ZV9ZyAqjjM5p1RNQ3y34lIlzcdrJoIzXzTA6v5T8khD5lszutT6
	nNzPOLVTNIwk8dmHnmpKVzQT1jJWGDkEB6u91j8asGGnDKN74RzJXh0dGvgRLTLQp4zzDDp8ElOxZ
	d7hgR2FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA2jI-00000005JNV-3dxV;
	Thu, 23 May 2024 07:19:12 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA2jC-00000005JHz-47aY
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 07:19:11 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240523071850epoutp04ce9d32e722eb1f6bd1268ba6d58b3b33~SDQaxi7SZ0096900969epoutp04o
	for <linux-nvme@lists.infradead.org>; Thu, 23 May 2024 07:18:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240523071850epoutp04ce9d32e722eb1f6bd1268ba6d58b3b33~SDQaxi7SZ0096900969epoutp04o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716448730;
	bh=jWCOeb8x4NIqcfn/S47RDrttegWDeSIWveRZexI/Bx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T7eEsAMBqajIntqs+tUrOXdE5z1Z8/yuEDyIRMsNOsKZ9gYuWcOk7RQ3Fox1R5MLF
	 bDdhUktVkH9xmaB7bbLSptz5rSGE5IznCRDsq0fZuB/4vvdDJ9b/7eQVD3Do2sHZDE
	 dj32iJotp0R1/wTpwPsSEWaQcnRrx0JF8rZPfJjk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240523071849epcas5p4e36fe28b6920bb4eb2fe8abd5274ef92~SDQaH4f1l1433114331epcas5p4L;
	Thu, 23 May 2024 07:18:49 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VlKKN3MGfz4x9Q8; Thu, 23 May
	2024 07:18:48 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6F.46.09665.8DDEE466; Thu, 23 May 2024 16:18:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240523070224epcas5p3e695021dfef14e09478bef71d4bb64ff~SDCE7vT5o0314003140epcas5p3U;
	Thu, 23 May 2024 07:02:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240523070224epsmtrp22e3d76a6e7aa74b89d002a30de5600bb~SDCE5d1aF0741007410epsmtrp2_;
	Thu, 23 May 2024 07:02:24 +0000 (GMT)
X-AuditID: b6c32a4b-829fa700000025c1-f7-664eedd8e7bf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	08.F4.08924.00AEE466; Thu, 23 May 2024 16:02:24 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240523070220epsmtip27aba71b0cc2f5f6b9888de9ca58d5e0e~SDCA-AENl3101731017epsmtip2E;
	Thu, 23 May 2024 07:02:20 +0000 (GMT)
Date: Thu, 23 May 2024 06:55:14 +0000
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
	nitheshshetty@gmail.com, gost.dev@samsung.com, Vincent Fu
	<vincent.fu@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 12/12] null_blk: add support for copy offload
Message-ID: <20240523065514.7745whk3pwem57cy@nj.shetty@samsung.com>
MIME-Version: 1.0
In-Reply-To: <631c55b9-8b0a-4ac0-81bd-acf82c4a7602@acm.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxTVxjGc+69vb1V0SuiOxbdoHNRYUA7W3Zg4owK3ATdWOZY4sxYR69A
	KG3txxxsThRBwQjC5pQCCq0ZFhAEqmIV53Cg8hG2ISKKVrHddFWpMjWGCWu9dfG/3/vx5Dnn
	ffNSuP9xvpBKV+lZrUquFJFTiOPnFi8Mu3L/gw3iAyWzUWNXJ4627XmOo7rrxSRynXsE0I/u
	ZzhynN0B0HhvH46snTcAqjJVEmjo7EkMnTaVYshS14Gh8n25GOqYvE+i0vbLADkHjBhquxqK
	qvMPEeh020UC9dsqSHTwJycf1ZyfwFDJzgEMtTq2AtTgGiXQhauB6PaunQD1PT/PWz6P6b+U
	wHSZIHPSeJ3P9N1oIpj+XgPTXFtAMi2HtjB3WsoAc2ooh2TMRd/zmN25D0jmZJ6dxzx0XiWY
	0TMDJFNkrQVMT9Wv/MRZ6zKWprFyBasNYlUpakW6KjVGlPBx8spkWaRYEiaJQu+KglTyTDZG
	tGp1YlhcutIzIVHQV3KlwZNKlOt0oohlS7Vqg54NSlPr9DEiVqNQaqSacJ08U2dQpYarWH20
	RCx+R+Zp/CIjrdl9i9C4pn/tfGLn54DhaYVAQEFaCguqy4lCMIXyp08BaG/vxrjgEYCmX/7h
	ebv86ScAWpv0LxWmUjPgmtoAnBjcg3PBGIDuEbNHQVEE/Ra8uz3UiyQdCrsnKa82gF4En9ys
	eeGG0xdIWN9wCfMWZtGxsLijhu9lP3olHDySz+N4JrxY5iC8LKDfg86nLRj3iD8F8P6zFRyv
	gnf+tZEcz4J/n7fyORbCsQdtvvwmaPnhMOk1hvR2AI2DRsAV3od5XcW4l3E6DT7O7/WJ58O9
	XQ0Yl58Od487fMZ+sPXAS34T1jdW+QzmwstPt/qYgfc6nb4J9WJw34FdYA943fjKh4yv+HEc
	DQvc23gcvwFzj5XjRs/wcDoQ1kxQHC6GjbaIKkDWgrmsRpeZyupkmiUqdtP/C09RZzaDFwcU
	ktAKRm66w9sBRoF2AClcFOD3mWXNBn8/hTwrm9Wqk7UGJatrBzLPrkpw4ewUtecCVfpkiTRK
	LI2MjJRGLYmUiF7zc+VVKvzpVLmezWBZDat9qcMogTAHMzQkPpxZa98gpuYQdb/ZJ1TrscMr
	oq998+2SEavb1blj2sJFObK7l/HyZXOSjnxiqW6xk/Ode9MP1m92FLkXJNkOVfSckA4P35MP
	vr0xcDSvrv67rLN1U6+3ln5ZPc9dOZA6fFsomOzosZwQPNXGJ80JNi+fGjwkevx7g+lo/Joz
	oY0jnxbbxgOOTS00fxRXVr7llivqZzr2c/9Y9ZkF+yaG9lIF8ZOPbjb2dsRfWSDOVqybn50c
	V0HGdx/rXzyjegZm7hFeO/pMtt+y+TgZ8scqV2512Gr+eGBSbd+iLLFhbO1fVkdsoTVz/3pt
	dsSHCWsTi0s2BjeZ8m8DcYrSqqvys+WLCF2aXBKCa3Xy/wBRiIfXyQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZdlhJXpfhlV+awb+lahbrTx1jtmia8JfZ
	YvXdfjaL14c/MVpM+/CT2eLJgXZGi99nzzNbbDl2j9FiwaK5LBY3D+xkstizaBKTxcrVR5ks
	Zk9vZrI4+v8tm8WkQ9cYLZ5encVksfeWtsXCtiUsFnv2nmSxuLxrDpvF/GVP2S2WH//HZDGx
	4yqTxY4njYwW616/Z7E4cUva4nF3B6PF+b/HWR1kPC5f8fY4tUjCY+esu+we5+9tZPG4fLbU
	Y9OqTjaPzUvqPV5snsnosftmA5vH4r7JrB69ze/YPHa23mf1+Pj0FovH+31X2Tz6tqxi9Diz
	4Ah7gHAUl01Kak5mWWqRvl0CV8ab/zYFf7grHvV0MDcwdnF1MXJySAiYSCyatJgRxBYS2M0o
	cfZ5EURcUmLZ3yPMELawxMp/z9m7GLmAaj4ySuxb28fWxcjBwSKgKvGyRRvEZBPQljj9nwOk
	XERAQ+Lbg+UsIOXMAmfYJM6t/Qc2X1jAVaL/6HJ2EJtXwFni+to2VoiZZ5kkrj3cApUQlDg5
	8wkLiM0sYCYxb/NDZpAFzALSEsv/cUCE5SWat84Gu41TwFri6ffNTBMYBWch6Z6FpHsWQvcs
	JN0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEJxMtzR2M21d90DvEyMTBeIhR
	goNZSYQ3eqVvmhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe8Re9KUIC6YklqdmpqQWpRTBZJg5O
	qQYmRaUzR2Yd3qp+u8xqc7q0yJ9SUZ2Dxqdtbl0qzrDnnKXMULDxRmmxba33rmbTiYGLo6oe
	Hr0reTbp2oVHGRvjr6QoX9TedyrZ6mmncup8uXmlJfnWPpFbar+8mvmns2qKLoNP75Tvoic+
	X/iz+dyfwM9HeJ0EHm5bm6C7+JTVr9nsXLc7L87PvD39IDvPYvV32XWN+x3UvroXOPBxx3mn
	xLr7Rug0SzBY3/jUH2DgzVP5b2VApPimTz/v7Di2aL0BE8/Slqymog6tbwvfuN5nXN+66cej
	lpWxrV139mxZOoXvy7wlL1flCh87/D/Ii9Eh/pNWRadvsf+NIrWQhynbHzJOSVG0fXT6hzLj
	phxrJZbijERDLeai4kQA8kXBwJUDAAA=
X-CMS-MailID: 20240523070224epcas5p3e695021dfef14e09478bef71d4bb64ff
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----0ARpVfROdpzmGW4Ln12FwIta42jNjH8le_L8dBWq-uMGoSqN=_1f5f7_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520103039epcas5p4373f7234162a32222ac225b976ae30ce
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520103039epcas5p4373f7234162a32222ac225b976ae30ce@epcas5p4.samsung.com>
	<20240520102033.9361-13-nj.shetty@samsung.com>
	<2433bc0d-3867-475d-b472-0f6725f9a296@acm.org>
	<20240521144629.reyeiktaj72p4lzd@green245>
	<631c55b9-8b0a-4ac0-81bd-acf82c4a7602@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_001908_665111_26E78AE9 
X-CRM114-Status: GOOD (  14.37  )
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

------0ARpVfROdpzmGW4Ln12FwIta42jNjH8le_L8dBWq-uMGoSqN=_1f5f7_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 22/05/24 10:52AM, Bart Van Assche wrote:
>On 5/21/24 07:46, Nitesh Shetty wrote:
>>On 20/05/24 04:42PM, Bart Van Assche wrote:
>>>On 5/20/24 03:20, Nitesh Shetty wrote:
>>>>+    __rq_for_each_bio(bio, req) {
>>>>+        if (seg == blk_rq_nr_phys_segments(req)) {
>>>>+            sector_in = bio->bi_iter.bi_sector;
>>>>+            if (rem != bio->bi_iter.bi_size)
>>>>+                return status;
>>>>+        } else {
>>>>+            sector_out = bio->bi_iter.bi_sector;
>>>>+            rem = bio->bi_iter.bi_size;
>>>>+        }
>>>>+        seg++;
>>>>+    }
>>>
>>>_rq_for_each_bio() iterates over the bios in a request. Does a copy
>>>offload request always have two bios - one copy destination bio and
>>>one copy source bio? If so, is 'seg' a bio counter? Why is that bio
>>>counter compared with the number of physical segments in the request?
>>>
>>Yes, your observation is right. We are treating first bio as dst and
>>second as src. If not for that comparision, we might need to store the
>>index in a temporary variable and parse based on index value.
>
>I'm still wondering why 'seg' is compared with blk_rq_nr_phys_segments(req).
>
In this case blk_rq_nr_phys_segments is used as counter value(==2), which tells
its a src IO. But using a macro instead of this comparison will avoid this
confusion. We will change this in next version to make it explicit.

Thank you,
Nitesh Shetty

------0ARpVfROdpzmGW4Ln12FwIta42jNjH8le_L8dBWq-uMGoSqN=_1f5f7_
Content-Type: text/plain; charset="utf-8"


------0ARpVfROdpzmGW4Ln12FwIta42jNjH8le_L8dBWq-uMGoSqN=_1f5f7_--

