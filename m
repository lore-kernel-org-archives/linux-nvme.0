Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C53AC3ABC9
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 20:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/R8ae7uVYcmyY3Zqf6KWGOelHffqTWgHabUihE8c3u0=; b=HlJj5vK4rB3xP9DRBG4NTmk/bq
	/fTpgfJh9d84NZjEeyPhm4pekub5VIg6AflbqYtKSxyHT40xyHnDyJfoBPdCMqFJrAqpKTUAC2L+t
	CfCnrFb7n3y/iGMylVQ0CoE6CZTwjfGiG2zKJAqYaef3sfRHBTLMIo4Vx2s8REBUPuIzORJX5Zdok
	AQ4Key6zqOJGPCAsUcVgudji0IXLXClOuKwlDEZNJMPK2w756ZL7vgqbZ/0/DBpGhuJep7DKZ1u+B
	C7sQ86qvN94PK8QL7QPHPqhjQTG+tXdt/VJmet16tw6rJ6Q/6i4M//7Eh7MtAC18jJmZtm+IkR+eI
	pIrXl5FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDUJv-00000004oxY-3JVg;
	Fri, 09 May 2025 20:27:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDSQf-00000004ZQe-1TQI
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 18:26:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 77CC35C6BDB;
	Fri,  9 May 2025 18:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384F5C4CEE4;
	Fri,  9 May 2025 18:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746815196;
	bh=/R8ae7uVYcmyY3Zqf6KWGOelHffqTWgHabUihE8c3u0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WAKz/c112w9LZ2Zm+Oi5hKjmOH2N9d0+kHRgxOdQGiQGtNJfOorPBgPtGlxyfvuth
	 IEAaU/ur4WxNAjM4ljIQ8VbhWopcu0VYILgLiN1U5Rbr9vLOGL3GqjZFiFR6Wg1lGG
	 uRk9q9Mr9uA4dAUnQv3Cc5cJla8FF/MMwvvGiN4bzw5a/LuVR+MlgxxInt+1UCOlSW
	 B0F3hl8ucE8E8UKNBj1Ux3VWWg1ImrNdEkNZYsW+r7g23LP/QYqfAeMrhJghIsRkCD
	 xPgwwT9ktE2hM/YHYXot1Dyt7VSOPB5wE4Nm0SDVsWxRL7AdtVGX+02v4DQ45tMgN2
	 RhQsuWJdFPrtA==
Date: Fri, 9 May 2025 12:26:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Eric Robinson <eric.robinson@psmnv.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: 'nvme list' shows 100% usage on empty drives
Message-ID: <aB5I2UjeRiudiQnu@kbusch-mbp>
References: <SJ0PR03MB65015EFAAC79F560121311CAFA8AA@SJ0PR03MB6501.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR03MB65015EFAAC79F560121311CAFA8AA@SJ0PR03MB6501.namprd03.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_112637_428737_58CD7D86 
X-CRM114-Status: UNSURE (   9.64  )
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

On Fri, May 09, 2025 at 03:46:03PM +0000, Eric Robinson wrote:
> Why does 'nvme list' show drives as fully used when they are not? Note that 4 of the drives show as fully used. These drives have been secure-erased.

The value here comes from your controller; "nvme list" is just the
messenger. The utilization is the Identify Namespace "NUSE" (Namespace
Utilization) field as reported by your controller.

The spec indicates this field is optional, section 2.1.1 of NVM Command
Set specification says: "the controller (...) may report a value in the
Namespace Utilization field that is always equal to the value in the
Namespace Capacity field." Sounds like your controller opted to use that
behavior.

