Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67CAC433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 17:00:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89ECF20776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 17:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gnh+Xqnm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r1QQkPc3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="iQB3wPgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89ECF20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fQg+EmS2jfg64TNvm0U/2ud73sQdbjV3YfgoRBqMSKs=; b=gnh+XqnmEQhRtWauSsJAhhPc4
	BmRqXRRlV8vaNFop/QbJh0cvzpruommaitewXLkoSLh0/bv0Y6Rjb4Aty7Y32Vy/0YK2xeiRsOS1C
	EPHJmssJnjnGUVD5kaJnTXPcVwPyw7V1CZlbA0SAri3i/S0QgvbabB1Rm7l9aGs/WKVCO0+tngbhJ
	sbVhPPrsZ/vR+fdVh/uR6xBCWMzLj8d/JH+kYbRsnDIT/C7eBrY1KEbXBTyepuajgRGG+Vb8Vm1ue
	b56Xk0qFsVrzzq2vfWSCr+WAJ9Ulj9zhqm3moWvj2bFI4oM1pg5rFPUhZV8AEoyon1Bh3gpDODcuO
	kJ3tx6i/w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBhju-0002IH-6s; Fri, 28 Aug 2020 17:00:34 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBhib-0001hg-Ba
 for linux-nvme@merlin.infradead.org; Fri, 28 Aug 2020 16:59:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:In-Reply-To:MIME-Version:
 Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Vu/qHBLUIdNYwHCfOCotYNrWQ2Zu4ikmtIZCxvhpy7U=; b=r1QQkPc3SI57tfXzF+OfL3WRQm
 +5cQCxRTBZO1WG/SvR6D569C4rpLHAF5Wi+sIucKdPzfHXvZ026hCGWQV/Woh86LStkQJWbYCKnzN
 qoZKHsIVj5ReJj/ireGnlR7BL9Ik7BBWiQJK/jBtZ8BUzi56WfpwjHTXFGLPsUARCUZN8TRxgSBUQ
 S3O+rdwI8mrpsr51BO58EK3YmmstqrG7oqY8gi/Ht5rMdilHuM/DkZTTe34cefNJMQnn5DbO/PQLx
 z96XeV27wYeS/PxdwcFl/6cA3ECcHgR4n6CbGbWhQiHaaW94q9Q+w0h4bUaq3vmz/mDYkPVe9VFjz
 8GcM+DoQ==;
Received: from mout.web.de ([212.227.17.11])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBhiW-0001nL-DP
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 16:59:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1598633933;
 bh=qkPTOvtTGRigAt7SKSkMWItH7Z6Xc3wPdBbL9u7L8Vc=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=iQB3wPgNpGISEa8EzUdbxng9py67qccf+mr1m9GO13OZI1S8z7oZYzUYOYuRI1jtY
 lGAMKZcO3ntcBbWHlCNvNDcl6btSVTZnmdAwobWCzgb1lLWcD5s12joQNXOSZ7skGu
 zUjs2hl4ez2QMTMU/BCMarrQoOZaRzKzJp5sPiB0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.21.78]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0McnqH-1jttkn3H4T-00HuiG; Fri, 28
 Aug 2020 18:52:56 +0200
Subject: Re: [PATCH] coccinelle: api: fix kobj_to_dev.cocci warnings
To: Julia Lawall <julia.lawall@inria.fr>, Denis Efremov <efremov@linux.com>,
 kernel test robot <lkp@intel.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-nvme@lists.infradead.org
References: <13cd8bf4-06f9-04d7-e923-c397c506e8cc@web.de>
 <alpine.DEB.2.22.394.2008272204050.2482@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8387e2b4-cf1c-c6d9-9da5-0bb12cff5e6c@web.de>
Date: Fri, 28 Aug 2020 18:52:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2008272204050.2482@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:uSXj4U8dSWh0urx+9uu9tjsUulylfI1zTfph9HN04SrhTi81gEF
 sfRIdwecDSoLTWXfGHQXujPWapdX99LQUbOw2V0C0YBTFmYw0XiL2PD2cRZeea2ZvwifTbH
 3aLTkxDKRXBrXKa0RY8mN0GVlzVm4C0aL5o2W9PVnjQAYpEK32+gXtKtI85lhNa4VCwLF4O
 TS0IIIWqb0wAhRxv9YZBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AhGkWd23Qe8=:yX9pZjDastA/RFkoTHXvCs
 RZtBZf87NnY1lxgaBwHYhccPqkrRg6Afy6es7HAdXP5v32pkQ9Cnezh8+v58+BC8L7d8Eadzk
 XbvXdexroErBp8b/d+hMOikfthqtjwSz3BBN8OKwPvmYgFiAb6pik96EXQX2Oj9vro4wBTpTI
 eqj7ck4pkO1eOZNgtliaHwR8IVWWDU75Fi5xDfasPYqK0sU6AUrgoL2G8Jc7JdTbt5CiJqrB5
 E+ewPIEhstfyAWRH91ffR1EEvHbtUpD+FRlIT2YZZloTH7z41cFIVg/e0Egw3jwS8agDChAhD
 dgYZr0lcscWY63HHXEb7PIFqZFtN7OiurKxtMdQDp70shFAqoBNPYfPE3fAkGV6c+B3LY9cEt
 h5tpVtJOK6xpgAHZBBfXlVofphwUDYWQ/DgOe6XjG/ES7DCW9ndhyBSDEpmSdF/nW4xJu/xOB
 cgK1JJwZhg1bwGYq+OGz9pBfauWS1dFtUuLWx8vq3Mb4c/tCLJwPOmHWrJqhkzY+hvZ0PwdNX
 +s1l1zOGqszD683gDJQogM3VgGmPmKYR95z0BD+eZoMbaCwvNyNWBfhpcAczKOL+jNTr9mB01
 m0A61PdsdE7Z0Q8JEVIDtNgpAZUR39Kr7P7aPu4A0/SZDqFZSOIaqILJ/07TTme8eMX+tBBcd
 5BPEGY4KGfQ/a4QISxM95/bn1a7pCxWQJ3pDihL3RLnXZ1vHG2uNEIG/lzxG8Mr0/RcS21BRS
 Ic8UCwPv3K+xAiGsLz2PgGybOdfP8DkH2yZOZbBeOp/IWiOWCU2IJL9Hak9SQWklERALRo9H5
 qCgPPBr/Wms/Iv6cu21gNKQtjJSZWVNFPPGuwNllcvQnucCLMTDGeKnlcaBsR/6F6SwWLlYVj
 hS6t05DYaZ4vfaaDjJD6hYDZhZeCFkNLfmWxAggPyBZTxT4UMwYy4QTauGElBAkPII1vsknvs
 lwVdT9QS/w8QSd9cJ5ozD06O3PICO20p4pLE3oFdUIP+t9UB2kyld13qcuho9tKBUrXJRMT0U
 1L30u0RdhONADP97Bvgmia2iJeWt7srZo+IKc6lk0Qdh21LS1wPgjX5lV+0r/8BVoP43qGjgg
 1tovNsWDPHQ5b1k1HwY2M0dM/OBFYrqmSskZCmz0ZR9gXR5YCwuoU+P1FHkwP9lciwzbk8828
 xj5/VLy6x6lQM22sk3HD1SAhJDjb5NtVPVxHEHUa8aFR22+Gzg091EzDvvFwldMl/1ITRJFk0
 neIl+vacLtlGLqRBrsoN/qHZAAe9sCv3SJVxxkA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200828_175908_602354_6DBC9077 
X-CRM114-Status: GOOD (  10.52  )
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
Cc: Jens Axboe <axboe@kernel.dk>, kbuild-all@lists.01.org,
 Sagi Grimberg <sagi@grimberg.me>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bernie Thompson <bernie@plugable.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> It seems that 0-day picks up new semantic patches that are added to trees
> in kernel.org, but that it's strategy for generating the patch is not
> ideal.  I'll just drop these Fixes lines.

* How do you think about to adjust also the prefix for subjects
  of generated patches?

  Another example:
  https://lore.kernel.org/linux-nvme/alpine.DEB.2.22.394.2008272211260.2482@hadrien/
  https://lore.kernel.org/patchwork/patch/1296616/
  https://lkml.org/lkml/2020/8/27/1377

* Do any scripts (from the continuous integration system) need further
  improvements for the safe and clear application of patch results?

Regards,
Markus

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
