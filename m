From: keith.busch@intel.com (Keith Busch)
Date: Mon, 26 Jun 2017 16:26:56 -0400
Subject: [PATCH v2] nvme: explicitly disable APST on quirked devices
In-Reply-To: <20170626070129.14744-1-kai.heng.feng@canonical.com>
References: <20170626070129.14744-1-kai.heng.feng@canonical.com>
Message-ID: <20170626202656.GA23862@localhost.localdomain>

On Mon, Jun 26, 2017@12:01:29AM -0700, Kai-Heng Feng wrote:
> A user reports APST is enabled, even when the NVMe is quirked or with
> option "default_ps_max_latency_us=0".
> 
> The current logic will not set APST if the device is quirked. But the
> NVMe in question will enable APST automatically.
> 
> Separate the logic "apst is supported" and "to enable apst", so we can
> use the latter one to explicitly disable APST at initialiaztion.
> 
> BugLink: https://bugs.launchpad.net/bugs/1699004
> Signed-off-by: Kai-Heng Feng <kai.heng.feng at canonical.com>

There's something off about the format with this patch such that it is
getting mangled when I save and apply it.

I'm not sure if the content type and encoding are the culprit, but that
just stood out as different. Normally patches I receive have this header:

  Content-Type: text/plain; charset="us-ascii"
  Content-Transfer-Encoding: 7bit

But this one has:

  Content-Type: text/plain; charset="iso-8859-1"
  Content-Transfer-Encoding: quoted-printable

In any case, I'll hand apply it with Andy's review.
