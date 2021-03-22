Return-Path: <SRS0=yO6k=IU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DE0C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 20:04:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5106157E
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 20:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5106157E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Wl7uYT2BEnLQXEPuu6YQb93IFQ1yAirz0Y6NpMv1fkk=; b=Vz0cJknOpCfvEiaRktcwjr9Xd
	OUfu3r47e8n53buqaKigFeD0zQCoaJcogPW1jY2HXYOB4XoQiQXlTh4mpqLk0ZDzpHAZ6v9m69Ssq
	Nqb/4Fd5ZhY0/8JEi9qC7QPntqd+64+FdsgM3bTSfUBwrHj3y9uaCD7cNj3b7i4WJMRqZyT0dI4Ei
	Yu6twfTmoeFvk5GI1JeeR6ZpPY291gHwMjx7NEd7ababBG3x2919O3+lPij+vWT3lDTbRcIIgJEFX
	SdjMm0XnYnt4r4ZMdSTbCCDjiMpfEA5OoeyNt/HZIrlWJozyb06LFMyy8397vBa2Mw3WGxBXLLbLN
	eP5hMUKxA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOQm3-00CTki-LI; Mon, 22 Mar 2021 20:03:39 +0000
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOQlw-00CTjc-SR
 for linux-nvme@lists.infradead.org; Mon, 22 Mar 2021 20:03:34 +0000
Received: by mail-qk1-x730.google.com with SMTP id y5so10402885qkl.9
 for <linux-nvme@lists.infradead.org>; Mon, 22 Mar 2021 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=68vl/yiYvmgcXyVIdTU5oV74UxAPTnnGu+cWQNyF8w4=;
 b=Uuy1g88XODXjEq+N9eRAau/chYdqT38iEE0ZTIA4H21cidDFG+Vk4U7W27oDRL2Lsh
 w2PyVr/agKoRR/842XN6fNpaFrWaNUbIOHu2OKmypnnzQigDHKmNh09Qy75saHLKBuRb
 GajYN6shT94CypuWcS+mUiIMXLxPmpR+5GZ2CkasuUGMwmDOwZxNd8VsZ4Eb9dgH4wFk
 4nG6ZZPF4dODQ/+4MQHKRXDKIg3tSrhlibe5KxTHFZgBx85EgNLPMyhvEK1jNMlfpJ4M
 mQfMBWaotBzv+4gPFYRgFb7Wb0xP0nQIeKV7nVeDmMfKESGppszNIvxGeHLnRrEdIw0Z
 4f/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=68vl/yiYvmgcXyVIdTU5oV74UxAPTnnGu+cWQNyF8w4=;
 b=n4TLJl2/s9QJDQXz/DKlfUcZuSAabErWUFUnBWErAh4GzvNkM0xwAI/eAqNd4slhuf
 pieNiwmcln100QcvK98g87oynb9GJnOL7cviqxPy7O4N6Ml5jBMC32Z3sP1jy8cpKrnq
 /orElSitAsPxTBQ5KgtWHj1WSLZDyrtNsDRnNtt6m2bm/82icu4GV5vHmlmFuv8leBLe
 JNGAoGZpI1ag9sZLRbPxnMha8nz2H6BS3A/v1omSFhK2h6eD1LD3HACyBPxqhBJqK109
 Ya7mcdrzNXaYUsrOogRAQBC/cu8f60tpEsf6abFI4j63rkE801X1CKb4IgdIQU64VvXR
 CSHg==
X-Gm-Message-State: AOAM532t21rATq4H1OH8lxdwcDrq2vwV8UNvsGFeXts7E7z3QYEqzZCe
 MmwFyrv/xoDm3UE4phYImH0=
X-Google-Smtp-Source: ABdhPJxZ83M8LxBajZE37Gr9K3JPE8kxXZ6WktUzoV/xI2BFQg5LUNL1PqSCy7iiIn8xEfJvbNiVZA==
X-Received: by 2002:a05:620a:102f:: with SMTP id
 a15mr1911430qkk.87.1616443410877; 
 Mon, 22 Mar 2021 13:03:30 -0700 (PDT)
Received: from ArchLinux ([138.199.10.68])
 by smtp.gmail.com with ESMTPSA id 8sm11483746qkc.32.2021.03.22.13.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Mar 2021 13:03:30 -0700 (PDT)
Date: Tue, 23 Mar 2021 01:33:20 +0530
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: Re: [PATCH] nvme-fc: Few trivial spelling fixes
Message-ID: <YFj4CKnnRg5lzN9K@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>
References: <20210320203002.13902-1-unixbhaskar@gmail.com>
 <BYAPR04MB4965A5E081F84BA874957F3186659@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965A5E081F84BA874957F3186659@BYAPR04MB4965.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210322_200333_138728_34313FBC 
X-CRM114-Status: GOOD (  10.41  )
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
Content-Type: multipart/mixed; boundary="===============2735998296624684756=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============2735998296624684756==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3smuvP2HPx3sPm+l"
Content-Disposition: inline


--3smuvP2HPx3sPm+l
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 18:36 Mon 22 Mar 2021, Chaitanya Kulkarni wrote:
>On 3/20/21 13:45, Bhaskar Chowdhury wrote:
>> s/boundarys/boundaries/ ..... two different places
>> s/assocated/associated/
>> s/compeletion/completion/
>> s/tranferred/transferred/
>> s/subsytem/subsystem/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>
>Patch looks fine but commit log could be better.
>
This is the best I could produce.
>
>

--3smuvP2HPx3sPm+l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBY+AQACgkQsjqdtxFL
KRVoYAf/Rag2bPMPPqtcm9y7wgH9ZcQVNcpKuGP/PPUmUVbzdkp/jxQcninJm+Pr
Uk5M0SCerITQS7rIFISBvQCmb0aG5GzyPhqqSB7oF/XdRqyHBgcS1ekXbYy2cQhF
Xb3t6GvOeTBU1U7GPd1n/TopSNA4wHcK1B55LKEotuNmFsxd2CJQf8KWl7iGTNMQ
Ah0Yr//dciF0kUFDYNFIygnhvZPCyQb1iqyOitc9nstHmzAHFp6zKNSnLgnaPRys
LSO6EfzRm0hMGkT9Upp+5cRfgT2Hy8ahFN7MbL0Bo1IU+qWBHU3rmS12xXP1sPVq
4YsGrl45jNjdlMYIbw9g50HS1U+6yw==
=0zL/
-----END PGP SIGNATURE-----

--3smuvP2HPx3sPm+l--


--===============2735998296624684756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============2735998296624684756==--

