Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1A1C6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 15:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Aw6/ylk7up2YyH4/ExR70uFOxXE2DGUdspXzt97n8dI=; b=yNhkobF5wZ3EtO+xoatQpvkEAN
	7oydA6p8XgHqDV/ua9RB3jE7C6RYgBNj0JGYq2IoR0jSN2LwOJvgR+rfFa+2WUnGtBi0gNaNZ6YOG
	vjXthPZNVwJdv6jkoa8nCf0u0+YmUtfHonrGbhMGzVMSPtVCY4v6cvvW/3ogJse8N+kIf3/XinqU/
	booCCwzEA014KyY3eXy9dzPKp9M1zrzm2/vVG7Mx5L/Q8Sfx9HU2P8hehSHr+JcWYHO2gYKSq85/5
	73VvkX0JxMtT4m3sBT+pfmqtU2IEtYY8/ZHy/VTnhRQ9DkCXEoVcnrKuJHtwNbkivaBjQbK1g81HZ
	Kii81TUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obOMQ-00GW7b-1K; Thu, 22 Sep 2022 15:43:34 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obOMM-00GW6e-PA
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 15:43:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 19FEE6363B;
	Thu, 22 Sep 2022 15:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3CFC433D6;
	Thu, 22 Sep 2022 15:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663861409;
	bh=yDZI/Bm7QY2X8kejE0Tl2XJQmzPy96219KJwqJ30Kdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b6ADD/65r3MeQwJpdPbhxV/SslZR54K0BLDqBVsqxqz74TdEgDx4LwGZDrbYAo3xP
	 zwCxsnlJ1w+8QX6HsEj1r15VseNGBQmuMFPgQVkK7GJpbkX23wF5pKeZ7lgTvvzRty
	 sPDKhND9HAk0Tto3OHE/PU20qCl1qKCOc+ckxZrUhILrZlK0ppzCFVJHDFXxmOkGO8
	 HD22sQIyjRcEQcnF7SLlC57s8kdbD1M25n7gvBFl4ePg4IoFMAuoTuDa9w6SXC1v5u
	 Df+ZIhYRfdVjcJ8NKsY9YoaPa6EjHPrt2/RIoKdINIUBEUdKx09SkPTGTIGVdsh52s
	 m/z4EMMp2E2fg==
Date: Thu, 22 Sep 2022 09:43:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nick Neumann <nick@pcpartpicker.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: nvme smart-log intermittently corrupt from family of SSDs
Message-ID: <YyyCnknAK2oCCcRH@kbusch-mbp.dhcp.thefacebook.com>
References: <CADqNVToq+rxkZTmagWcW5s2g+pVpfwBX17wS6C4xm6wszHkGTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADqNVToq+rxkZTmagWcW5s2g+pVpfwBX17wS6C4xm6wszHkGTA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_084330_878198_4A06AC3B 
X-CRM114-Status: GOOD (  14.76  )
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

On Thu, Sep 22, 2022 at 10:37:29AM -0500, Nick Neumann wrote:
> I noticed something odd with the smart data from various sized HP
> FX900 Pro SSDs. Intermittently, after hours of use, host_writes would
> be 0 (but data_units_written would not). After experimenting, I'm
> seeing that intermittently, when running either "smartctl -x" or "nvme
> smart-log", the data coming back is, uh, junk?

I'd recommend taking this sighting to the device vendor. Either the drive is
returning garbage, or possibly nothing at all and the tool is reporting stale
data from where ever the buffer was allocated. The drive did respond to the
command with a success, otherwise the tooling wouldn't attempt to print the
data.
 
> sudo nvme smart-log /dev/nvme0n1
> Smart Log for NVME device:nvme0n1 namespace-id:ffffffff
> critical_warning                    : 0
> temperature                         : 48 C
> available_spare                     : 100%
> available_spare_threshold           : 25%
> percentage_used                     : 0%
> data_units_read                     : 793353
> data_units_written                  : 4938926
> host_read_commands                  : 18675956
> host_write_commands                 : 40381344
> controller_busy_time                : 0
> power_cycles                        : 9
> power_on_hours                      : 15
> unsafe_shutdowns                    : 1
> media_errors                        : 0
> num_err_log_entries                 : 217026295083295649698117473405925064704
> Warning Temperature Time            : 1323299686
> Critical Composite Temperature Time : 4108885430
> Temperature Sensor 1                : 38041 C
> Temperature Sensor 2                : 55225 C
> Temperature Sensor 3                : 23326 C
> Temperature Sensor 4                : 38685 C
> Temperature Sensor 5                : 57125 C
> Temperature Sensor 6                : 45486 C
> Temperature Sensor 7                : 59856 C
> Temperature Sensor 8                : 2107 C
> Thermal Management T1 Trans Count   : 1702871148
> Thermal Management T2 Trans Count   : 312071619
> Thermal Management T1 Total Time    : 406823074
> Thermal Management T2 Total Time    : 468107429
> 
> Even odder, when the host_write_commands was 0, the rest of the data
> was sane. So the incorrectness is not always obvious...
> 
> Any recommendations or thoughts on dealing with this? Or am I just out
> of luck when it comes to relying on anything from these drives' smart
> logs?

