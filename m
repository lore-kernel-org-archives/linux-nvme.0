From: bdeyal@gmail.com (Eyal BenDavid)
Date: Tue, 6 Nov 2018 20:59:09 +0200
Subject: nvme-cli: connect-all failed with EALREADY but exit code is 0
In-Reply-To: <ba138474-6091-baf8-09c3-d0908b84523e@broadcom.com>
References: <CAPrnrPDk+Mopaoni030JJ49TKCe95Vv7AfJDFT7_99zXaBUBqw@mail.gmail.com>
 <ba138474-6091-baf8-09c3-d0908b84523e@broadcom.com>
Message-ID: <CAPrnrPAAMXjFV+dH6+NySfP0sHXCdWq=QRKJ5sYiqZ6hj3JxOQ@mail.gmail.com>

On Tue, Nov 6, 2018@8:50 PM James Smart <james.smart@broadcom.com> wrote:
>
> it is the way it was written.
>
> And the fact it's already in progress is intended and is not necessarily
> an error unless you are trying to create 2 controllers using the same
> <host_traddr, traddr, hostnqn, hostid, subnqn>. And if that was what you
> intended, there's the "duplicate_connect" argument, granted it has to be
> used on a connect, not connect-all, basis.
>
> -- james
>

Thanks,

That's reasonable but only if the error is EALREADY.

For any other errno the exit code would still be 0.

Eyal
