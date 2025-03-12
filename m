Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AA6C282EC
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Mar 2025 02:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B74DKmkBkIdJM4Sb1P0qf00X8M+idQpMzhYOiFT1AYY=; b=zS4Xb+so30q6WCDjvbHIULl1Zs
	nQfYm5qHtMOFkGgaplVU2pgOpN1JzLV7qI9h77JkQc6Cnh2Ck3sJf4QvfB0WduCgCQN7gqhJGMnp8
	wm0Y9N9FVfpuMdSKUqAZaYt5qQb+RHpC7VJpYwPAes/hz4VAh61cUCiQxYM24eE3Ub1ySsKjYCa4/
	1cZoELy0QcUfk3glKd9lGkBFRWwT8Hk3ufECpMXLmDGF/RX9wsN6Z1pKthIcOEQv4288V8EdcxGu6
	6oWOdu41TF8InbBVAZYmZrqDAXi5nQbNk4CjiXNbhoJRBWjGJNPqNzCBEJFX/prTOlMLvMvWZ5MbL
	vjvxbYxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsBwo-00000007N5R-2mIA;
	Wed, 12 Mar 2025 02:35:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsBwl-00000007N53-3VfB
	for linux-nvme@lists.infradead.org;
	Wed, 12 Mar 2025 02:35:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741746949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B74DKmkBkIdJM4Sb1P0qf00X8M+idQpMzhYOiFT1AYY=;
	b=fUPVeowhfsIoxH/6YBkTC6nhrMOqaqDu+mLnLEBMfK27o/xqOBYtKsK/jxVpgAK2sR99cw
	CsH0yxpZmuvXxfS+U2mt1by9MZ84h67a+e/CkFJkfXLI6kTPXKlERzReW3cmabNIsP1Qrk
	y7stWc3ozgSfHJ8zxcRhG+3CYyn61CM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-UgLV66XYOUyJX1HkQt1YGA-1; Tue,
 11 Mar 2025 22:35:45 -0400
X-MC-Unique: UgLV66XYOUyJX1HkQt1YGA-1
X-Mimecast-MFC-AGG-ID: UgLV66XYOUyJX1HkQt1YGA_1741746944
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5D7F180035C;
	Wed, 12 Mar 2025 02:35:43 +0000 (UTC)
Received: from [10.22.65.26] (unknown [10.22.65.26])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8371195608F;
	Wed, 12 Mar 2025 02:35:41 +0000 (UTC)
Message-ID: <03e7cc64-fafd-405e-a07a-4bc6d0e1d743@redhat.com>
Date: Tue, 11 Mar 2025 22:35:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme-multipath: add the NVME_MULTIPATH_PARAM config
 option
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, loberman@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 emilne@redhat.com, bgurney@redhat.com
References: <20250228032541.369804-1-jmeneghi@redhat.com>
 <20250228032541.369804-3-jmeneghi@redhat.com> <20250305143353.GB18526@lst.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20250305143353.GB18526@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_193551_960593_4D6F6B4E 
X-CRM114-Status: GOOD (  14.54  )
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

On 3/5/25 9:33 AM, Christoph Hellwig wrote:
> On Thu, Feb 27, 2025 at 10:25:39PM -0500, John Meneghini wrote:
>> The NVME_MULTIPATH_PARAM option controls the core.nvme_multipath module
>> parameter. When NVME_MULTIPATH_PARAM=n the multipath parameter is removed
>> and core nvme multipathing is enabled. When NVME_MULTIPATH_PARAM=y
>> the multipath parameter is added and multipath support becomes
>> configurable with the core.nvme_multipath parameter.
> 
> What's the point of adding yet another confusing option?

If you'll read the kConfig description, hopefully it's not confusing.

The whole point of this patch series is to remove the core.nvme_mulipath parameter.

This is what the patch at: https://lore.kernel.org/linux-nvme/20250204211158.43126-1-bgurney@redhat.com/
does, and this is what this patch does. Since people didn't want to remove core.nvme_multipath parameter
in  https://lore.kernel.org/linux-nvme/20250204211158.43126-1-bgurney@redhat.com/ I've proposed this
patch as an alternative.

It provides a kConfig option to remove the core.nvme_multipath parameter so those who want it
can keep it, and those who don't and compile it out.

/John



