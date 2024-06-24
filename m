Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77025C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 17:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KOiS5FoPxiz3yCGlJ3uxJuLKtY3Ob/DdJ4UYYfEkG50=; b=tJ/xspqFvWocAKGvl5TA+6dZcu
	eeubs5odPh1O6nWG1DUr103S+BE4B1MbPPvOG0tANg70A2B+boz0OEhT4O222nUXvceYvHh+E1Mgc
	vfgiqqffXOjEzH1ZHRbGKeK8XYKjJnPz+np4gqi1QrbRd1MVBiUdPMXrpywquwdgz5rgLYqDhAguc
	1SklENfmn7wDRnK10i2FuL6Wqtc7NtKwozExEwV2oYXVNf/pEFfKaqzy5RwEBOlWB1TyZb0r5Toh5
	kJ4+HrzGK25gfRUt+BGblbttFURh1Nk/4CY+0NDWPlh5HiB2Zjt06KGRtFwrZ+F7RGzZukvxeSYSX
	flqJ+4ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLnpr-00000000ADw-3dZM;
	Mon, 24 Jun 2024 17:50:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLnpn-00000000ABJ-3qAB
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 17:50:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719251429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOiS5FoPxiz3yCGlJ3uxJuLKtY3Ob/DdJ4UYYfEkG50=;
	b=D0+233T1jGIs6gfouIZjsbsJyvmV3KkIfS2jeeB/K8U91W2xSCTdBDrv30/DLNB1pUbiNt
	NstYzBIQbqo8obMcml2R9Rr8JtvcYFQH4XN2s37mWdPqDuS8NXH+yN7CXGjADwogbTYKBG
	a9AoagT8XRb1x4Hk2Vz6fKjCS31qsbI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-jrghYZZyO1q-m9qtYVT7ww-1; Mon,
 24 Jun 2024 13:50:27 -0400
X-MC-Unique: jrghYZZyO1q-m9qtYVT7ww-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBF52195608B;
	Mon, 24 Jun 2024 17:50:24 +0000 (UTC)
Received: from [10.22.34.111] (unknown [10.22.34.111])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73E4F1956087;
	Mon, 24 Jun 2024 17:50:22 +0000 (UTC)
Message-ID: <59921b0a-1e16-4f39-bdda-9e11ba2edbbd@redhat.com>
Date: Mon, 24 Jun 2024 13:50:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] nvme-multipath: implement "queue-depth" iopolicy
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, emilne@redhat.com, jrani@purestorage.com,
 randyj@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org
References: <20240619163503.500844-1-jmeneghi@redhat.com>
 <20240619163503.500844-2-jmeneghi@redhat.com> <20240620065641.GA22113@lst.de>
 <d4ae4b0a-b3a4-40db-87e3-c9a493408172@redhat.com>
 <20240624084627.GA20032@lst.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20240624084627.GA20032@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_105032_070182_A0E21A4E 
X-CRM114-Status: UNSURE (   9.23  )
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

On 6/24/24 04:46, Christoph Hellwig wrote:
> On Thu, Jun 20, 2024 at 01:54:29PM -0400, John Meneghini wrote:
>> How about:
>>
>> pr_notice("Changed iopolicy from %s to %s for subsysnqn %s\n",
>>                  nvme_iopolicy_names[old_iopolicy],
>>                  nvme_iopolicy_names[iopolicy],
>>                  subsys->subnqn);
> 
> Having the identification as the prefixe seems easier to parse
> and grep for.

To be clear Christoph, your saying you'd like the NQN in the prefix of the dmesg?

E.g.:

root> echo "round-robin" > /sys/class/nvme-subsystem/nvme-subsys11/iopolicy
[Thu Jun 24 11:44:20 2024] subsysnqn nqn.1992-08.com.netapp:sn.2b82d9b13bb211ee8744d039ea989119:subsystem.SS104a iopolicy 
changed from queue-depth to round-robin.

Correct?

/John


