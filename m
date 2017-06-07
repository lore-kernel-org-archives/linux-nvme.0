From: luto@kernel.org (Andy Lutomirski)
Date: Wed, 7 Jun 2017 08:20:00 -0700
Subject: [PATCH 1/2] nvme: only consider exit latency when choosing useful
 non-op power states
In-Reply-To: <20170607072543.14071-1-kai.heng.feng@canonical.com>
References: <20170607072543.14071-1-kai.heng.feng@canonical.com>
Message-ID: <CALCETrWSaTuimvv+_pC+gzJxkLHj8oc4iZErVHL4nzjRDUpZjA@mail.gmail.com>

On Wed, Jun 7, 2017 at 12:25 AM, Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> +                       exit_latency_us =
> +                               (u64)le32_to_cpu(ctrl->psd[state].exit_lat);

Trivial nit: the case is no longer necessary.
