Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2135CF318A
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Nov 2025 10:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4su06mGzhk94GbhmfDkG9OwKm6H/6d1Z1AxmTQtJ2bo=; b=2Aq7wvD26tz8NR0HJT0WaVg5aq
	xaYMAbanMPBmiilHwExkH60Ex12yt22JR2Hl8ZW8l27/KjwyLkm6dFmUCm6MX6it6KIKotzf7yg3O
	dmWdqQm8gZDBX5gWOKsFqhcltZ0ZKIL0biL4R0NHJAfxvLeJ4Mgha6BeV2qnxubKJju5MzH93uYC+
	M49raE2EfEDMoVYg8Aypem4egi8TC/Yv699wr15yXdWyef7wVKv3K7xsFd68wwdYhF3qezInVCzV6
	pItbeAHRl7XflZekUl7kqu72E3wh1yll2erK9MJIC4jwjh80UPFQKAWpNTmITAA1iKbB7B/uFoMby
	1PcGierg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLfJu-00000002x7Y-0vgE;
	Wed, 19 Nov 2025 10:21:50 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLfJs-00000002x79-0fgd
	for linux-nvme@lists.infradead.org;
	Wed, 19 Nov 2025 10:21:49 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-b735487129fso1047993866b.0
        for <linux-nvme@lists.infradead.org>; Wed, 19 Nov 2025 02:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763547706; x=1764152506; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4su06mGzhk94GbhmfDkG9OwKm6H/6d1Z1AxmTQtJ2bo=;
        b=h3WpFsHc69siKWnBN+fBNr89jwmNNMv2pv0+h5UdD1ZNOXW66z9c/DnpGz7fo3vXdY
         qIBz/8NByILbT4HYvz5hUtD0nNtAWK77LC0mXpObMlpZl+ODZk4Sisazva06GaiDiXYZ
         nTj1RvyWiXtMRGkEQkK2AnIitS8CreO+D6j47qmEcliPAHFuuBspy3MccXGlKaCA7guK
         fSBGY6iNvuQm9HNLb7lnRdin2MHbP+CNNOOhG60h336k1xQo4JrSWVnBvdywRX0eFXto
         4jq7atmIPvImvA9FFztDgvnrSfOSeKFVVSxJAEFzNcUo7em+TgejzVl+1g9plqgmMUJa
         OZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763547706; x=1764152506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4su06mGzhk94GbhmfDkG9OwKm6H/6d1Z1AxmTQtJ2bo=;
        b=orXZhYQIWkfRuktwtqHA9sxi5joHIlDaep0BHgQDJL3or6bs8gaE2ireQykzE5YE4v
         +rZz6R625YqUboCz7SBqW4DRhtMppAuJMNW+HKRQK0EUdSVrIx5AYNucYK0ddoP4zbz6
         djq7AyLDBn/CBI3RFv5NGM+tRgTFa4ZIuPvxvgXa19DBOWbRuDeH0H7NPPS2Xm7TW0Ow
         wjnu2U2YsZmxm0XyW3Cwl64rVOK3tizV3rNpnzNkD6UiuT/NGYmJ41Q4hR1anC++3ak1
         kJW+FO/NNMFvSc6B7IUTHFyXJCgNoVXMXB6Lv9qA6u66On6cynbh1xQpfZsHldfPIa2V
         w9Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUWFn0HPGxQXS3osByB6lK1yGWiQcKn8/ho8c/sp1Kam3+1RaEb0DdIQPLjjcao8G4tbPbi6gBoalaL@lists.infradead.org
X-Gm-Message-State: AOJu0YyUmt8TBmi/YqT5gfHhlaH6+IpWhdMzLzVqqUu0rBmCVjv9jWS4
	qDEielTbACBBc5Oujx/12s94biaLfWiA+zaj9jR69QIPQ1zCJB8ZVvt7GDCq6VZVHy9X8Y0qs4N
	c1eKtxbOvcABUC4H6jlnkDlqQpvYn0L4=
X-Gm-Gg: ASbGncvr0i4/zssqTFxliUOfxzjYAuuuXzkqri13mSbhG1xQkZhBVpwiI0xUpAcZvON
	THMMiV6EGdjwzHp3Ze/b+sU/83vLiVzpE4BT6oEaeRAVDmiSYHdpU8eX9YMrYHAo4F3yzX6oguY
	pOePfH3KxROeB+w5jbdHRmNXhuL1pYHynH230nxuGgHqjt4IbAZX9rOe1HAR1OYBlaGf3ECr7M9
	/G3vOt7xFG2C/1k+t6t63IHbq6mZRm8NXQCU0b8xlq5N/fskb3+iqN92qCng92y2T6EYC2S89N/
	MjaQAE4Zf4Lq+WH1/Ivms3o6jd36rsBUOmRy
X-Google-Smtp-Source: AGHT+IG5zdp3/4GjZI4udomhBulURlVnP+rT8sUcfJz4vJ+/G6OOQCZWqp68abh+5YTFSRUitrEVTsZZorc1MLB4NQ8=
X-Received: by 2002:a17:907:8dc3:b0:b73:544d:b963 with SMTP id
 a640c23a62f3a-b73677ed424mr1625000166b.13.1763547705597; Wed, 19 Nov 2025
 02:21:45 -0800 (PST)
MIME-Version: 1.0
References: <20251114045850.1898865-1-alistair.francis@wdc.com>
 <20251114045850.1898865-5-alistair.francis@wdc.com> <e15b39ad-bfdf-4177-86b7-99c84975825e@suse.de>
 <CAKmqyKNViQjZHyftdj7anoF1Wsf9qeRZQiZ9yfM_FsJAcmx7jg@mail.gmail.com>
 <fd9c30d3-2a9f-4ddc-9d71-436034637acb@suse.de> <CAKmqyKMNESv2T=0pqVAqXg-5NfmTJ1qzaHAi3c9e7tCe5uF6Kw@mail.gmail.com>
 <60e86d7c-f926-4b75-96eb-dc8fd8a06ee8@suse.de>
In-Reply-To: <60e86d7c-f926-4b75-96eb-dc8fd8a06ee8@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 19 Nov 2025 20:21:19 +1000
X-Gm-Features: AWmQ_blKFp2S1UKb6f4OOt3qyccwGUfyVbV7QnJF3CAKS1i1BT_89ImqeYuxB5M
Message-ID: <CAKmqyKOTqDovbBt3ThxAO+nmBkp0Zm=cuFa-M1f0t5qRyv+49Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] nvme: Allow reauth from sysfs
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251119_022148_230231_8218C056 
X-CRM114-Status: GOOD (  40.70  )
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

On Wed, Nov 19, 2025 at 5:45=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 11/19/25 01:24, Alistair Francis wrote:
> > On Tue, Nov 18, 2025 at 9:50=E2=80=AFPM Hannes Reinecke <hare@suse.de> =
wrote:
> >>
> >> On 11/18/25 01:52, Alistair Francis wrote:
> >>> On Fri, Nov 14, 2025 at 5:15=E2=80=AFPM Hannes Reinecke <hare@suse.de=
> wrote:
> [ .. ]>>>>
> >>>> Hmm.
> >>>> Now we are just running (re-) authentication, but that does
> >>>> not affect the TLS connection (which continues to use the
> >>>> original key). So you would need to reset the connection
> >>>> here to re-establish a new TLS connection.
> >>>
> >>> Is the connection supposed to be reset? I don't see any mention of
> >>> that in the spec
> >>>
> >> Yeah, that's a bit hard to read (as usual).
> >> The base spec just claims (Fig. 733, Secure Channel Protocol Identifie=
rs):
> >>
> >> 03h: This {PSK, PSK Identity} pair replaces the {PSK, PSK Identity}
> >>     pair that was used to set up the TLS secure channel over which the
> >>     authentication transaction is performed.
> >>
> >> So from that your implementation is correct, as it just replaces the
> >> PSK (without actually using them). However, the TCP spec clarifies
> >> (section 3.6.1.4: PSK Use):
> >>
> >> Once the TLS secure channel for the Admin Queue of an association
> >> has been set up with a generated {PSK, PSK Identity} pair, that
> >> generated {PSK, PSK Identity} pair should be replaced periodically
> >> (e.g., every hour) or on demand by performing a reauthentication
> >> with the SC_C field in the AUTH_Negotiate message set to REPLACETLSPSK
> >> (refer to the AUTH_Negotiate Message section of the NVM Express
> >> Base Specification) over the Admin Queue of that association. The most
> >> recently generated PSK, if any, is the generated PSK associated with
> >> that Admin Queue.
> >
> > Yeah, to me "associated with" doesn't necessarily mean that we reset
> > the connection to use the new PSK.
> >
> But then why would we want to replace the PSK if it's not used?Which
> would be completely pointless for secure concatenation, as
> for _any_ connection establishment a new PSK will be generated.
>
> And I've checked with FMDS, the intention really was that REPLACETLSPSK
> should result in the new PSK to be _used_ for existing connections.

Ok, so tear down the connection and reconnect. I'll work on adding that

>
> There's now a bug for this:
> https://bugzilla.nvmexpress.org/show_bug.cgi?id=3D638
> and it should be addressed with an ECN.
>
> >>
> >> And the only way to associate a PSK with the admin queue is to use
> >> it for the TLS encryption, ie re-run the TLS handshake.
> >>
> >> Or indeed use the KeyUpdate mechanism.
> >
> > This is the part that I think is weird.
> >
> > If we do need to use the new PSK, once a host issues a REPLACETLSPSK
> > we have to tear down and restart the TLS connection. Which seems
> > really clunky and the spec doesn't seem to mention that at all.
> >
> > If the host wants to replace the TLS keys it can just issue a
> > KeyUpdate, which doesn't involve tearing down the entire connection.
> > So do we actually need to reset the TLS connection after a
> > REPLACETLSPSK?
> >
> Oh, I fully agree. KeyUpdate would be the way to go to get a seamless
> PSK replacement. But not all implementations do it (currently not even
> the linux kernel :-), so in the absence of that we have to reset the
> queue to start a new TLS handshake.

Urgh, let's get everyone supporting KeyUpdate then :)

Alistair

>
> Cheers,Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

