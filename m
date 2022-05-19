Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48E5C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 20:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F5BZ3O+bhwTaIL5NhxZYlpfgKqGgS1UyE/dsZi/ciJ4=; b=sjJ6HYrpVFyYNe7bx8Ueh5Uoh9
	lVTw90YNKd40lYA4uWVR+41zKExy/YQVrSYQtGyenvP/9vSv1d6LJFXt0rDDEQTU9hTkU7frXN/Fk
	+LYM9SZz9PFihGTVuCfO5sXt4ppfGZYIbeg9ssCez8C3We9EqqGdFvuHc+rg2+SdkVHF/tDASzgeB
	EK9+t0choGw/9TGTImVVA1kjwrkbFZZ2zUCSGhiomfKKHYmPpdv9Id4zIcVEbsoI98xm+BZrOiogD
	CKIeeIOMevey3oNS744dVjgkjG/L4HHOWZYOSvrMjJfpfWgLIB94bpe/mu3ytivE+OkX/NWOla5iA
	M3Yunftg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrmLc-009BuS-Kq; Thu, 19 May 2022 20:02:12 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrmLY-009Bu1-TB
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 20:02:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5F6A9B82813;
 Thu, 19 May 2022 20:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05C0C385AA;
 Thu, 19 May 2022 20:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652990526;
 bh=4BseRWIVSc+5jvZ2ujILwhLdeW2VEXLysFStBBxozrk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uIUSph33jixVfQQ8A2R+aKXK92fUQf4xLACQMfIWqTzQ+abgrdIhPrKM3w8FdfGov
 Qx0/McZBJFYBaMkPT+PBLgZxX3pfg4GACCiXGYxErNLoEefrJEwURsClBJNLyXuA2v
 uXnNuwoDRFkL2zFj5/jYFGvgBiF6DY6KIRyIwQ76ctIggdCnD+1Vl9Pz8LxVZyVtAW
 gcNoZd0LC/gTO7But6yxjk6Hn+sYsdOL2vijJhovH/e1XvI1KrInOnDDIh3UBVs941
 eWXNL0iRWLgdGf4uS6oy3GCvhKxDFMLMNTqK8vpFrZqSNdO3cZenp3qw4n/qA0Iiw/
 PuHSenDYbXGAg==
Date: Thu, 19 May 2022 14:02:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Marcos Scriven <marcos@scriven.org>
Cc: linux-nvme@lists.infradead.org
Subject: Re: My Western Digital SN850 appears to suffer from deep power state
 issues - considering submitting quirk patch.
Message-ID: <YoaiO2yze7UaYZK6@kbusch-mbp.dhcp.thefacebook.com>
References: <5ea81a6a-b510-40d2-9b32-036f263f75f3@www.fastmail.com>
 <YoFYIJ3/yEK1RGTK@kbusch-mbp> <YoKQ4YHKEZxd8C2N@infradead.org>
 <4486f6fd-0fa8-4cee-9cbe-35f017ea6ceb@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4486f6fd-0fa8-4cee-9cbe-35f017ea6ceb@www.fastmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_130209_269189_B153207D 
X-CRM114-Status: GOOD (  25.54  )
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

On Thu, May 19, 2022 at 11:14:41AM +0100, Marcos Scriven wrote:
> 
> I have now tried both of these options (separately and together), and the issue still occurs. I confirmed settings in command line:
> 
> cat /proc/cmdline
> BOOT_IMAGE=/boot/vmlinuz-5.13.19-6-pve root=/dev/mapper/pve-root ro quiet video=efifb:off acpi_enforce_resources=lax nvme_core.default_ps_max_latency_us=0 pcie_aspm=off
> 
> Does this mean it's definitively not a power state issue?

If you're still seeing this same all f's failure even with these settings, I
think it rules out the autonomous power settings provided by nvme and pcie.

It doesn't necessarily rule out potentially platform specific power
capabilities, but that'd be well outside my view of the nvme driver stack, and
I don't have any ideas off the top of my head on what to even check.
 
> The slightly positive news is I now have a fairly dependable way of replicating the issue. I've described it over in the Proxmox forums (https://forum.proxmox.com/threads/what-processes-resources-are-used-while-doing-a-vm-backup-in-stop-mode.109779/) but in short, just backing up a container (from the affected drive, to an unaffected one) has about a 30% chance of causing the drive to go offline. I suppose the fact this happens is another indicator it's not to do with lowering power states (autonomous or otherwise) if it's happening right when the disk is being read.
> 
> I tried running strace on the process to see if I could see anything obvious about what the process is doing while it fails, vs what happens when it completes without error. I can't see anything obvious.
> 
> Another thing I tried was a raw dd read from the affected disk to dev/null, to see if it was something about intensive reading that causes this, and it did not happen. During that the controller temp maxes out at 63C. nvme smart-log doesn't show any critical warnings.

63C, not great, not terrible.

'dd' is a nice tool, but you may be able to push the drive further with 'fio',
assuming an intense read workload is pushing the drive to failure. Just a quick
example:

  # fio --name=global --filename=/dev/nvme0n1 --bs=64k --direct=1 --ioengine=libaio --rw=randread --iodepth=32 --numjobs=8 --name=test
 
> I'm wondering if there's anything that would help me identify if it's a hardware issue (PSU, SSD, motherboard) in terms of low leve debugging or BIOS settings.

It does sound hardware related, but I'm not aware of any reasonable tools or
methods to debug it. Right now, I can only recommend verifying you've got the
latest vendor provided firmware installed.

> As an complete aside on mailgroup protocol, my understanding is text only, and 'inline' style. Responses come both from the group and directly from the people replying - should I "reply all" or just the group? For now, I've gone for the latter.

The mailing list only accepts plain text. Top posting is generally frowned
upon. A reply-all is fine. Wrapping columns at 80 characters helps readability.

