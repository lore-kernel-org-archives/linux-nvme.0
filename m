Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D65C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Dec 2021 16:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uuOhXUtE24bXpUebgdQRFjeX5kNVDPwblKL0j9L0wvw=; b=mVkFBVNTqQp+C3kLB17iBZIHN9
	9eGHeDEgOSHzsPxTFxODPti+ej+Xfvg1odYW1aD/rY7grVcQW87Etm2x+/5SmE4Rwjg1O5F13XiAy
	iaRTZyPhMAbVodYc/toqMoxzylEU+dfLAnKvAfaVPt9SSn8YLgYGXbhq3AWDwppo5rNjJ2/S44HtI
	fn/fYHNIgKLe2EwGBO3tEnxkP5jf0J06lo86uLBnhw6g+IA0bohTJBX8JUTjhnyJmvRUoliNWGCrH
	CpEOTMlT6bQ/DdWl+cyg8a3bfI8aEqBq+E4zgGU6a0AOar3WeOe4TJzzT2RR2PyQkvoxhLC3pmdtu
	vQe2tBHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n1sXJ-00GxL3-Bl; Mon, 27 Dec 2021 16:07:45 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n1sXD-00GxKe-Ao
 for linux-nvme@lists.infradead.org; Mon, 27 Dec 2021 16:07:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4DDD8B810E0;
 Mon, 27 Dec 2021 16:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB19C36AE7;
 Mon, 27 Dec 2021 16:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640621255;
 bh=D6+dKdGMG3Yvw/IBOckSs51FhOyHM7KS8o7IQqYeEYc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kx23G8x2uDiutKpY12FjfXmB7QywrpSFGA3EOrnALJGVmuu+wbLOEeRq/u8xLPELi
 m8Rw9l3r/hf5jcD0NhMUUU62L7+P7Tz6sexB6+YdUzAQHI5sxsG5UAX8zu18eAED//
 ogfo04+znaRo1JIiu8CK4Fr1xpuj5BuYVRM6O8hzLeXoXxtWxq7tnIYwEIFcatUyi6
 wInZ0pVMSmM0lBmEhTF/uDWsu/t7WVQKLKhHAm0TA9Y0gheaM4FPeX4quvnJSpiPQv
 yeOYvKkFS/4clm9joYhGI/9O3I+i1ZtG9HO8qXUYyo9sz5L8G+wTK1/JRa4HiKPeU5
 RG3ymk+l1tVCg==
Date: Mon, 27 Dec 2021 08:07:32 -0800
From: Keith Busch <kbusch@kernel.org>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH V2 1/1] nvme: Add verbose error logging
Message-ID: <20211227160732.GB2207198@dhcp-10-100-145-180.wdc.com>
References: <20211223215726.71096-1-alan.adamson@oracle.com>
 <20211223215726.71096-2-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223215726.71096-2-alan.adamson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211227_080739_558472_EB91359D 
X-CRM114-Status: GOOD (  11.66  )
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

On Thu, Dec 23, 2021 at 01:57:26PM -0800, Alan Adamson wrote:
> +
> +static const char * const nvme_errors[] = {
> +	"Success",
> +	"Invalid Command Opcode",
> +	"Invalid Field in Command",
> +	"Command ID Conflict",
> +	"Data Transfer Error",
> +	"Commands Aborted due to Power Loss Notification",
> +	"Internal Error",
> +	"Command Abort Requested",
> +	"Command Aborted due to SQ Deletion",
> +	"Command Aborted due to Failed Fused Command",
> +	"Command Aborted due to Missing Fused Command",
> +	"Invalid Namespace or Format",
> +	"Command Sequence Error",
> +	"Invalid SGL Segment Descriptor",
> +	"Invalid Number of SGL Descriptors",
> +	"Data SGL Length Invalid",
> +	"Metadata SGL Length Invalid",
> +	"SGL Descriptor Type Invalid",
> +	"Invalid Use of Controller Memory Buffer",
> +	"PRP Offset Invalid",
> +	"Atomic Write Unit Exceeded",
> +	"Operation Denied",
> +	"SGL Offset Invalid",
> +	"Reserved",
> +	"Host Identifier Inconsistent Format",
> +	"Keep Alive Timeout Expired",
> +	"Keep Alive Timeout Invalid",
> +	"Command Aborted due to Preempt and Abort",
> +	"Sanitize Failed",
> +	"Sanitize In Progress",
> +	"SGL Data Block Granularity Invalid",
> +	"Command Not Supported for Queue in CMB",
> +	"Namespace is Write Protected",
> +	"Command Interrupted",
> +	"Transient Transport Error",
> +	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,

Tracking these NULL's is going to be problematic and error prone.

I recommend indexing the strings as you define them. For example:

static const char * const nvme_errors[] = {
	[NVME_SC_SUCCESS] = "Success",
	[NVME_SC_INVALID_OPCODE] = "Invalid Command Opcode",

etc...

Then you don't need to bother tracking the undefined indexes or making
sure everything is in order.

