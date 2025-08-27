Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86475CA0FED
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Aug 2025 20:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PFjUhe9yLmtYwTID+lsmcjtC1tjrv0oVqEHiDeb6CF8=; b=gIDb7xeVja3ZFY49luI4sQ+9OL
	9foRLGB1cYE5gVhPCvQ4Uzi5srbeV426X4v+S8br9UwHMBAc42J2CdRAJw2khaGlSRzugVlJWimPu
	/zVtVU641RoFEFDE+ApXnV+eGn4B1FXumhMr6y0G5zY+thK8Pl0OYkQxxJMyQH2NDR7r7srLv4OtB
	uH+77Vv9JjTm1PjXDjGPBavt5QZ6Z6zD+Z04nARjltr3IQy904PJICZof7sD110DAncSp05BUHDbT
	80OFnHMX9ds9SZROmbThcAiNqNf1SJq5GDxBG7tlCrPN1W6r0YV9LkyNB9HHJghGKqRYXdm6+uX+j
	RjMpdYEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urMh8-0000000GkFK-16xG;
	Wed, 27 Aug 2025 20:24:34 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urMCE-0000000GfrM-1Mw5
	for linux-nvme@lists.infradead.org;
	Wed, 27 Aug 2025 19:52:39 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E7D802011E;
	Wed, 27 Aug 2025 19:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756324356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFjUhe9yLmtYwTID+lsmcjtC1tjrv0oVqEHiDeb6CF8=;
	b=glRBMb0D3oyXYqZilGfeaVetGVCtejmJALI4CspzlL47RyXgYKzY22vMA8tQVf+nj6a4u5
	kFYg7/k3dLBpAZsypA8ddorYEOOwJPtb/32ddDxCvONsJ19JzudyM+f9VV3JhLj3u0lLf+
	zzf2w0+DCGZWDAiBKKkBEnOul1OfRhw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=jjN7anHt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756324355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFjUhe9yLmtYwTID+lsmcjtC1tjrv0oVqEHiDeb6CF8=;
	b=jjN7anHtnVmTN0gN0oNSrESPlLfmUy6fs9Pulh0jCqbGuhs3VnYEuPh6zQMLUKsqyArSKv
	AXrLzLktQMmjpV43tW/a8EC+CePs/4b6Ksd6MzlgTtvVcOe51oBS6KXp4hzD3J+/9r9Dre
	mS85MuNs+o5QL+hRlR0GcQtfYNR3oGk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51D0413867;
	Wed, 27 Aug 2025 19:52:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OgMPEgNir2g2XAAAD6G6ig
	(envelope-from <mwilck@suse.com>); Wed, 27 Aug 2025 19:52:35 +0000
Message-ID: <9804a889fe213a0cdab885baee37da7cd6c5e8c1.camel@suse.com>
Subject: Re: [PATCH v3] nvme-cli: nvmf-autoconnect: udev-rule: add a file
 for new arrays
From: Martin Wilck <mwilck@suse.com>
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc: Wayne Berthiaume <Wayne.Berthiaume@dell.com>, Vasuki Manikarnike	
 <vasuki.manikarnike@hpe.com>, Matthias Rudolph	
 <Matthias.Rudolph@hitachivantara.com>, Martin George <marting@netapp.com>, 
 NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>, Zou Ming
 <zouming.zouming@huawei.com>, Li Xiaokeng	 <lixiaokeng@huawei.com>, Randy
 Jennings <randyj@purestorage.com>, Jyoti Rani	 <jrani@purestorage.com>,
 Brian Bunker <brian@purestorage.com>, Uday Shankar	
 <ushankar@purestorage.com>, Chaitanya Kulkarni <kch@nvidia.com>, Sagi
 Grimberg	 <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig	 <hch@lst.de>, Marco Patalano <mpatalan@redhat.com>, "Ewan D.
 Milne"	 <emilne@redhat.com>, John Meneghini <jmeneghi@redhat.com>, Daniel
 Wagner	 <dwagner@suse.de>, Daniel Wagner <wagi@monom.org>, Hannes Reinecke
 <hare@suse.de>,  Benjamin Marzinski	 <bmarzins@redhat.com>, Christophe
 Varoqui <christophe.varoqui@opensvc.com>,  BLOCK-ML
 <linux-block@vger.kernel.org>, NVME-ML <linux-nvme@lists.infradead.org>,
 SCSI-ML	 <linux-scsi@vger.kernel.org>, DM_DEVEL-ML
 <dm-devel@lists.linux.dev>
Date: Wed, 27 Aug 2025 21:52:34 +0200
In-Reply-To: <20250820213254.220715-1-xose.vazquez@gmail.com>
References: <20250820213254.220715-1-xose.vazquez@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
X-Rspamd-Queue-Id: E7D802011E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL8gn1pxsi5paq6ucqz1qzjyqe)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250827_125238_524937_57CED26A 
X-CRM114-Status: GOOD (  25.92  )
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

On Wed, 2025-08-20 at 23:32 +0200, Xose Vazquez Perez wrote:
> One file per vendor, or device, is a bit excessive for two-four
> rules.
>=20
>=20
> If possible, select round-robin (>=3D5.1), or queue-depth (>=3D6.11).
> round-robin is a basic selector, and only works well under ideal
> conditions.
>=20
> A nvme benchmark, round-robin vs queue-depth, shows how bad it is:
> https://marc.info/?l=3Dlinux-kernel&m=3D171931850925572
> https://marc.info/?l=3Dlinux-kernel&m=3D171931852025575
> https://github.com/johnmeneghini/iopolicy/?tab=3Dreadme-ov-file#sample-da=
ta
> https://people.redhat.com/jmeneghi/ALPSS_2023/NVMe_QD_Multipathing.pdf
>=20
>=20
> [ctrl_loss_tmo default value is 600 (ten minutes)]
>=20
>=20
> v3:
> =C2=A0- add Fujitsu/ETERNUS AB/HB
> =C2=A0- add Hitachi/VSP
>=20
> v2:
> =C2=A0- fix ctrl_loss_tmo commnent
> =C2=A0- add Infinidat/InfiniBox
>=20
>=20
> Cc: Wayne Berthiaume <Wayne.Berthiaume@dell.com>
> Cc: Vasuki Manikarnike <vasuki.manikarnike@hpe.com>
> Cc: Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>
> Cc: Martin George <marting@netapp.com>
> Cc: NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>
> Cc: Zou Ming <zouming.zouming@huawei.com>
> Cc: Li Xiaokeng <lixiaokeng@huawei.com>
> Cc: Randy Jennings <randyj@purestorage.com>
> Cc: Jyoti Rani <jrani@purestorage.com>
> Cc: Brian Bunker <brian@purestorage.com>
> Cc: Uday Shankar <ushankar@purestorage.com>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marco Patalano <mpatalan@redhat.com>
> Cc: Ewan D. Milne <emilne@redhat.com>
> Cc: John Meneghini <jmeneghi@redhat.com>
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: Daniel Wagner <wagi@monom.org>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Martin Wilck <mwilck@suse.com>
> Cc: Benjamin Marzinski <bmarzins@redhat.com>
> Cc: Christophe Varoqui <christophe.varoqui@opensvc.com>
> Cc: BLOCK-ML <linux-block@vger.kernel.org>
> Cc: NVME-ML <linux-nvme@lists.infradead.org>
> Cc: SCSI-ML <linux-scsi@vger.kernel.org>
> Cc: DM_DEVEL-ML <dm-devel@lists.linux.dev>
> Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
> ---
>=20
> This will be the last iteration of this patch, there are no more NVMe
> storage
> array manufacturers.
>=20
>=20
> Maybe these rules should be merged into this new file. ???
> 71-nvmf-hpe.rules.in
> 71-nvmf-netapp.rules.in
> 71-nvmf-vastdata.rules.in
>=20
> ---
> =C2=A0.../80-nvmf-storage_arrays.rules.in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 48
> +++++++++++++++++++
> =C2=A01 file changed, 48 insertions(+)
> =C2=A0create mode 100644 nvmf-autoconnect/udev-rules/80-nvmf-
> storage_arrays.rules.in
>=20
> diff --git a/nvmf-autoconnect/udev-rules/80-nvmf-
> storage_arrays.rules.in b/nvmf-autoconnect/udev-rules/80-nvmf-
> storage_arrays.rules.in
> new file mode 100644
> index 00000000..ac5df797
> --- /dev/null
> +++ b/nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in
> @@ -0,0 +1,48 @@
> +##### Storage arrays
> +
> +#### Set iopolicy for NVMe-oF
> +### iopolicy: numa (default), round-robin (>=3D5.1), or queue-depth
> (>=3D6.11)
> +
> +## Dell EMC
> +# PowerMax
> +ACTION=3D=3D"add|change", SUBSYSTEM=3D=3D"nvme-subsystem",
> ATTR{subsystype}=3D=3D"nvm", ATTR{iopolicy}=3D"round-robin",
> ATTR{model}=3D=3D"EMC PowerMax"

Do you have a specific reason to add the model match after the
assignment? It isn't wrong AFAIK, but highly unusual and confusing.

> +ACTION=3D=3D"add|change", SUBSYSTEM=3D=3D"nvme-subsystem",=C2=B7
> ATTR{subsystype}=3D=3D"nvm", ATTR{iopolicy}=3D"queue-depth",
> ATTR{model}=3D=3D"EMC PowerMax"

I am assuming the idea here is that if queue-depth is unsupported, the
second command will fail, and thus round-robin will be selected?
I am not sure if that's a good idea.=20

The "best" iopolicy doesn't depend on the storage array in use.
It depends on what the kernel supports, the workload, and the user
preferences.

I suggest using something like this instead:

ENV{.NVME_IOPOLICY}!=3D"?*", ENV{.NVME_IOPOLICY}=3D"queue-depth"

This allows users to add a early rule file 00-nvme-policy.rules
to override the default:

ACTION=3D=3D"add|change", SUBSYSTEM=3D=3D"nvme-subsystem", ENV{.NVME_IOPOLI=
CY}=3D"round-robin"


Then you could simply do this:


ACTION!=3D"add|change",=C2=A0GOTO=3D"iopolicy_end"
SUBSYSTEM!=3D"nvme-subsystem", GOTO=3D"iopolicy_end"
ATTR{subsystype}!=3D"nvm", GOTO=3D"iopolicy_end"

ATTR{model}=3D=3D"dellemc-powerstore", ATTR{iopolicy}=3D"$env{NVME_IOPOLICY=
}"
# other models ...

LABEL=3D"iopolicy_end"


Anyway, I dislike the idea of maintaining a potentially ever-growing
list of storage models with special policies in generic udev rules.
Udev rules=20

*If* we want to pursue model-specific settings, we should rather use
the systemd hwdb [1] for that purpose. For example,


ACTION=3D=3D"add|change", SUBSYSTEM=3D=3D"nvme-subsystem", ATTR{subsystype}=
=3D=3D"nvm", \
    ENV{.NVME_IOPOLICY}!=3D"?*", \
    IMPORT{builtin}=3D"hwdb nvme_subsys:$attr{model}

# .NVME_IOPOLICY would be set by hwdb if a match was found
ENV{.NVME_IOPOLICY}=3D=3D"?*", ATTR{iopolicy}=3D"$env{.NVME_IOPOLICY}"


Vendors could then just put their preference into the hwdb.

But first of all I'd be curious why this setting would be=C2=A0
model-specific in the first place.

Regards
Martin

[1] https://man7.org/linux/man-pages/man7/hwdb.7.html

