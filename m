Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC533E67A8C
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 07:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=emzxcalxhefyJPtrnF5BVbzsZJUc4QzYRAPUO5dkvYQ=; b=ZIi/3jXv5Tn97qjrFhj55mUqed
	udGlU0RQH1ltnK7nhVQFiGAfgEdIT1fFbdazLTTNUAfWvTdYbywsq4a+BM9AZvHEPgGX5d/u9Lc9e
	2OZjHAKvJJ+OUG+h1+aJQB05xh+kNtMfhCf/q44NejQJhRJRQ8tsipUJIIoMBBCr76zG0KmgN6vJJ
	y0dDWtXYjbcJU223sBAIDa6gBhsS9Yq+PqIDL3EKF1YgOGO/wJWIilWnEyRyXsFoO0Khts2lkSimZ
	i6rg+SvwtrMqOZYSNGEGKi+rICxaW15FhkYWlncCCVcc/CxOGcFuvKeWorNM48mXZGdkfhbGfyDOz
	fMzYl8eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxK2d-0000000Ef5z-3tFL;
	Tue, 03 Mar 2026 07:19:39 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxK2a-0000000Ef5W-413k
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 07:19:38 +0000
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-439b611274bso1220261f8f.3
        for <linux-nvme@lists.infradead.org>; Mon, 02 Mar 2026 23:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772522375; x=1773127175; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emzxcalxhefyJPtrnF5BVbzsZJUc4QzYRAPUO5dkvYQ=;
        b=aUR50neq2HPAJveaoCF14rfH/C7yTvNGHUA6nuuR7l2Ef7ip1bO2Rc3S2Qa2SkBOR5
         0oHkMlPVIIpMlpOWo8GXqZePII3qfS9e+G58q/yzwvlW45y/udlfYAqKE9JcJhLTZgaw
         rnKanoR7kT35DTKl/kx/XM0S9jBKG4UyAo+PENMdIEKbtYaVNKlYL3+87+9CyOcfjxng
         CzvA2f4xJF6TEhsVTgLdmV3q6cvuJRBcCWWME20s46JEiquDmGMocRmYD7YELNml93XM
         03qK0pdD+HUhvQBAluerXvw43qOgefE0O04ICz8IwEPLYe1RgpgWjwpTxIM4l72ry7Up
         rUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772522375; x=1773127175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emzxcalxhefyJPtrnF5BVbzsZJUc4QzYRAPUO5dkvYQ=;
        b=htMg7pwFkMnU6vYbZvv270xCbdv/2A88UA1p0IOaZFJeMPMGBPt0vh8r+3phBwyhxP
         +Y4qfRLyisRMWwrYKUtlj/x6pw3jtYKQSPlxFo0w4peF4O+PfCxJ2ThO8jKt+fLLwwTy
         LOqUSe8E2BNwir5LrbZiGRu1eJTEbBMybbZq7hH6qGLseye1Kz//Z6W2xYPPff9LX8KJ
         J8EkFbKWCA/Dr1aeb5rv4olR2mtK+79z4lAPTz8S6BqiGSyAlatTtG9xhCNusBToMiRg
         9kR0XrzB4V/dxkjE8r2YfLyltwVUY2Z2p/oh02Jm3WBYhFOwy7URB0+DwgaUkHEe1XFF
         IrMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ25I8279v/AXbQ22KwG3CVLOrzKzZn23lbO94P4J7rJx5jOlpC8KoVN714YCIRrZfu/Fg55Mk+kqS@lists.infradead.org
X-Gm-Message-State: AOJu0YyQImubwG4eNgWom2vHL2163vPe8EgcgKXFGGQGSwhCMuVPTFEp
	RnYSSRRZfp21IRzvNRk91kiYRt2VZZwdGV2KOtqLT7OtyLBP52zyHJLJBsu6bmsWK50=
X-Gm-Gg: ATEYQzyGZ2pVwaFsJODp0eZLpJJR4cVcA9AbdGpD3QXC+5eoNuPkIyHbVYXJgE4U/uC
	wF4ZPuceG3NbIMwub2LUW3jNhwssJjyAWf4Fe629Un/ksrtHJjK6wKkzckx/STr9/nSTaCVgWgX
	Ma6fQ1i2JA3Uj5PiNDqMaKLkriQG+ZtpPIPbDxDiHND6njDSCklK5mpgXichesqwOw70FetBqTB
	/U2+HDfrXmdgKDmefYamngLvaaNoVJygKEojn6hVD77tkEhTaorqkZAbKSL2wPum3hWvSoci9bS
	oJkjVSCwIXW/01Rn6vyhrHPyWtrIlwwA3GzyonSWwjs6IGyV/gJBKzj9tuosLgrqIM82+/v+0Ln
	ITz+t3AW6TH6kVLXzlUVamnwAlbQfWb4L1jMu25b+DptFHwr0jk1Mdm7j088jfb5OkwDUkzdzkJ
	0ntP4kUpC5pwG37GNhLBSFcXPdzh+k3bdhvLNyL+nlG6BkC9B7012o6O40cp+y7vv4bw==
X-Received: by 2002:a05:600c:1d0e:b0:480:3bba:1cac with SMTP id 5b1f17b1804b1-483c9bc55c0mr240863065e9.6.1772522375015;
        Mon, 02 Mar 2026 23:19:35 -0800 (PST)
Received: from [192.168.178.47] (aftr-82-135-83-117.dynamic.mnet-online.de. [82.135.83.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7030b9sm370239755e9.4.2026.03.02.23.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 23:19:34 -0800 (PST)
Message-ID: <3c173449-bad5-4d74-bdff-4fc9fe4df566@suse.com>
Date: Tue, 3 Mar 2026 08:19:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] scsi-multipath: provide sysfs link from to
 scsi_device
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com, martin.petersen@oracle.com,
 james.bottomley@hansenpartnership.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, michael.christie@oracle.com, snitzer@kernel.org,
 bmarzins@redhat.com, dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-6-john.g.garry@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260225153627.1032500-6-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_231937_011163_B6C5665D 
X-CRM114-Status: GOOD (  10.94  )
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

On 2/25/26 16:36, John Garry wrote:
> Provide a link in sysfs from a scsi_mpath_device to member scsi_device's.
> 
> An example is as follows:
> # ls -l /sys/class/scsi_mpath_device/0/multipath/
> total 0
> lrwxrwxrwx    1 root     root             0 Feb 24 12:01 8:0:0:0 -> ../../../../platform/host8/session1/target8:0:0/8:0:0:0
> lrwxrwxrwx    1 root     root             0 Feb 24 12:01 9:0:0:0 -> ../../../../platform/host9/session2/target9:0:0/9:0:0:0
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/scsi/scsi_multipath.c | 45 +++++++++++++++++++++++++++++++++++
>   drivers/scsi/scsi_sysfs.c     |  5 ++++
>   include/scsi/scsi_multipath.h |  9 +++++++
>   3 files changed, 59 insertions(+)
> 
And again; just what I complained about in the previous patch.
Still not sure about the naming; 'multipath' conveys to me
the opposite (ie the multipath device, not the devices which
are part of a multipath device).

But anyway.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

