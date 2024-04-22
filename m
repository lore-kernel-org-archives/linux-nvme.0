Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4B8C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Apr 2024 02:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k12JuyA+cKhERmwqNvELFDbih5jDJ56gVK3Xe5BGr5A=; b=bjQS5C+i8uPlWsJ0khO8KSaAUb
	u+1PmfVmsuGq6ZXxE7xa3hNzaxXtp4JuF29+ycC7yH15fLQ+5N1OnbzvhioenQJuh7NF7JWJVGumC
	wzaZ3hKJcdtPvd/6ouCn9jRK+WLGUq0/MZZWGI7CZ7goELujwZtn4S3YevdGRLsjHPNd3dfCeKHl0
	ESjBj0s3bstjR24FqdiaKcx2m/i5YM2o7e8mFMhFpS9cb/TzOUzBEzCIZMqV67A8OD5s+bWaZ0H0H
	rOsyVCv55L8c65eaZ59jixwS8OWseWlMlAYjk2T+T91+9RtwoSUMkrhmWEHRauqEIYOnVl2jzNdV6
	D5fLS2lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryjl3-0000000BnNc-05Jq;
	Mon, 22 Apr 2024 02:50:17 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryjl0-0000000BnMq-0BDV
	for linux-nvme@lists.infradead.org;
	Mon, 22 Apr 2024 02:50:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 33E2BCE094C;
	Mon, 22 Apr 2024 02:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09251C113CE;
	Mon, 22 Apr 2024 02:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713754200;
	bh=9CAxTatN9AYkhOniCZqCxG0z5IleoiAxrG/HUhFKtKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IOb/CZRGFLLwqV8gVOWIenHkZ6tRlEGtKxyhrT2jkmvcNcKpQ8OsXq6hPykLSZA5l
	 YJUdkD92toHKhP2L3c0YTLvfAWGaBrcLzhVmYmKQw1VAxXHmN7LqIW5CZkxsWWUPcx
	 XqiGtUX5ew87LZWihicCqtH90kKr5a+tfr6KHu+l8Ezy7CmPuKBiYCZYM7/TqqbJCr
	 qryFWCT1Yy5dr2rPj/SswKM2iPJhT4ZWZfJaYQqG1/o/tyWOHjQb8DibmOOfATXrJ9
	 2U2bPgS8tNhdOQA/WT7clXzaPAyA/+NWXVHF9zpcYyCSXaYxf2KQzl3zE/q77Y0bof
	 y/rk8nAYCKnJg==
Date: Sun, 21 Apr 2024 20:49:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Deane Coleman <deanewcoleman@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: help re using nvme-cli to sanitize SSD
Message-ID: <ZiXQVWiuIpa0FdVx@kbusch-mbp.dhcp.thefacebook.com>
References: <000001da9459$f353b340$d9fb19c0$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001da9459$f353b340$d9fb19c0$@com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240421_195014_485663_260EE296 
X-CRM114-Status: GOOD (  23.94  )
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

> I have an Acer laptop containing 1 x internal Samsung NVMe PCIe SSD running
> Win11 OS and I wish to completely sanitize the SSD of all user data,
> including over-provisioned / non-allocated space, whilst leaving vendor boot
> capability intact (if possible) and causing least wear on the SSD. Once
> sanitized, I wish to clean install Win 11 OS on the SSD. This is the
> objective.

What do you mean by "vendor boot capability"? The acer laptop? Or the
SSD bootstrapping itself? If there's something on the SSD that acer
needs to boot, sanitize will likely wipe it out.
 
> My limited use of nvme-cli identifies the SSD has only one controller
> 'nvme0' (with nvme0 containing all SSD data) and one namespace 'nvme0n1',
> however I presume (and please correct me if I'm wrong) the 3 above mentioned
> partitions in Linux = nvme0n1p1 + nvme0n1p2 + nvme0n1p3.
> 
> Based on above info (and presuming that info is sufficient), I respectfully
> ask whether the following procedure will 'smoothly' achieve the objective:
> 
> 1: backup all user data currently on SSD
> 2: have bootable Win11 ISO file prepped on USB drive via Rufus
> 3: boot laptop using Ubuntu Live USB
> 4: Open command terminal and run command - 'nvme sanitize -a 2 /dev/nvme0n1'
> to start block erase sanitize operation
> 5: when sanitize operation is complete, exchange Ubuntu Live USB for Win11
> USB and reboot laptop
> 6: Follow Win11 install procedures
> 7: Install Acer drivers
> 8: Install target apps

I don't know about step 6 there: why would you want to install that OS?

Kidding aside, assuming your device supports sanitize, step 4 will
definitely make all previous data inaccessible on all parititions,
including the partition table itself, essentially giving providing you a
blank slate storage device. If that's what you want, mission
accomplished.

Some devices don't support the sanitize operation though, in which case
'nvme format' is usually sufficient to permanently remove all previous
user data. You often use sanitize only if you're required to have a
paranoid decomissioning process.
 
> Additional questions arising from above:
> - If any above element won't achieve objective, please clarify what needs
> amending?
> - I currently understand 'nvme sanitize -a 4 /dev/nvme0n1' (crypto erase)
> causes least SSD wear but because all user data on the SSD is currently
> unencrypted, I presume crypto erase is pointless to achieve objective?

It's going to be vendor specific what that does, if anything. An SSD
might transparently generate and persistently store a random pattern and
XOR all user data with that, so a crypto erase could just forget the old
key.

> - I've tried researching the following sanitize options but am currently
> unable to appreciate their significance or relevance for the objective: 'No
> Deallocate After Sanitize' and 'Sanitize Action...001b - Exit Failure Mode'.
> Would you please help me discern whether I need to include either of these
> options to meet the objective and, if so, the correct syntax placement in
> the sanitize command for it/ them.

Don't bother with "no-deallocate", it probably doesn't mean anything to
this SSD anyway.

The "Exit Failure Mode" is how the host acknowledges a previous sanitize
attempt failed. You shouldn't have to worry about that because we're
expecting everything to work.

Once you start your 'santize' operation, the only other thing you need
to periodically check with nvme-cli is 'nvme sanitize-log /dev/nvme0'
until the operation is done. You probably don't want to reboot the
machine while the santize operation is in progress.

