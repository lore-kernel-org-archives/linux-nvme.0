Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E625C6FD1D
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 18:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:In-reply-to:Date:Subject:Cc:To:From:References:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OGbOFJayhgRcXq5FMeS6bRDyUolQeucd8waNYOur4j4=; b=VHhJnVFnofaFCE2LOKKWBF/0UP
	t390ivmCfVecpAz+DfyHkinwa7mPSYfPR9LxM0Nd8LqUhSEVvmJLiLSJdX+GIwspws1ldiZaTR1sB
	DrBSfFFeTXwtPYIetsBVWDZ61aHrMwGCPij4pjzxBDG/pfAucK4IoHHe+3Vke0QxAf/A7raQJwFAT
	N3RVCOAZRitIqGJgYWK8me01oO4WD1BWvproyTb3pgCgz2LOXLoL9fhZMyuDUnv6oqCYAZdOffkfk
	8dQVVo+Q2yK/yK3agZ7oTiLeXbVlS88lVX7OBXgOykPvuhThbSRReOgZ8uG9fdr7MWA+c+b+QGU8c
	TYx7nsfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgrEf-00BzdD-1t;
	Mon, 27 Mar 2023 18:06:25 +0000
Received: from mx.n90.eu ([65.21.251.117] helo=mx2.n90.eu)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgrEb-00Bzbl-0X
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 18:06:23 +0000
Received: by mx2.n90.eu (Postfix, from userid 182)
	id 74FC31027DB46; Mon, 27 Mar 2023 18:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n90.eu; s=default;
	t=1679940370; bh=OGbOFJayhgRcXq5FMeS6bRDyUolQeucd8waNYOur4j4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to;
	b=nPD85CB4IjQubR+FqhGXUYhBxV7bbwiHtN9kDpUsMfvJ5VKjUsWV88RDwd2C5oy4/
	 9tlJmIwPVi3rnu2uF27A0Xua2/i08lUSZ8Yll0MXwtsw+rld4069lz2IM8kPcwxggO
	 phjBZkPfcy0QaShZxkSowFm5huqTrA2RmJl4unv3BE9WpLw5cHrd/vU7l+6slZ5l9/
	 p7m9eSvV87wcasXYp44lZW2pwDpGg8ecJrJGUayyE9ySjUesRCJHONIfC7Dbqvhl94
	 Nfe8MHZJvedo8D6w1a4cBrMOGJeF/f9TiWznHy5d8o12ZS2UBdgtiZxheA/fa2BBpK
	 PygFgKG/87wsA==
Received: from spica (unknown [172.20.188.202])
	by mx2.n90.eu (Postfix) with ESMTP id CD5411025BB5A;
	Mon, 27 Mar 2023 18:06:07 +0000 (UTC)
References: <20230327143359.GA2834753@bhelgaas>
 <ZCHB6hXbCOxiZw+n@kbusch-mbp.dhcp.thefacebook.com>
User-agent: mu4e 1.8.14; emacs 30.0.50
From: Aleksander Trofimowicz <alex@n90.eu>
To: Keith Busch <kbusch@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Lukas Wunner
 <lukas@wunner.de>, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 217251] New: pciehp: nvme not
 visible after re-insert to tbt port]
Date: Mon, 27 Mar 2023 17:43:18 +0000
In-reply-to: <ZCHB6hXbCOxiZw+n@kbusch-mbp.dhcp.thefacebook.com>
X-Mailer: boring 1.0
Message-ID: <871qlank6o.fsf@n90.eu>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_110621_735015_06D336BC 
X-CRM114-Status: GOOD (  16.03  )
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


Keith Busch <kbusch@kernel.org> writes:

> On Mon, Mar 27, 2023 at 09:33:59AM -0500, Bjorn Helgaas wrote:
>> Forwarding to NVMe folks, lists for visibility.
>>
>> ----- Forwarded message from bugzilla-daemon@kernel.org -----
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=217251
>> ...
>>
>> Created attachment 304031
>>   --> https://bugzilla.kernel.org/attachment.cgi?id=304031&action=edit
>> the tracing of nvme_pci_enable() during re-insertion
>>
>> Hi,
>>
>> There is a JHL7540-based device that may host a NVMe device. After the first
>> insertion a nvme drive is properly discovered and handled by the relevant
>> modules. Once disconnected any further attempts are not successful. The device
>> is visible on a PCI bus, but nvme_pci_enable() ends up calling
>> pci_disable_device() every time; the runtime PM status of the device is
>> "suspended", the power status of the 04:01.0 PCI bridge is D3. Preventing the
>> device from being power managed ("on" -> /sys/devices/../power/control)
>> combined with device removal and pci rescan changes nothing. A host reboot
>> restores the initial state.
>>
>> I would appreciate any suggestions how to debug it further.
>
> Sounds the same as this report:
>
>   http://lists.infradead.org/pipermail/linux-nvme/2023-March/038259.html
>
> The driver is bailing on the device because we can't read it's status register
> out of the remapped BAR. There's nothing we can do about that from the nvme
> driver level. Memory mapped IO has to work in order to proceed.
>
Thanks. I can confirm it is the same problem:

a) the platform is Intel Alderlake
b) readl(dev->bar + NVME_REG_CSTS) in nvme_pci_enable() fails
c) reading BAR0 via setpci gives 0x00000004

--
at

