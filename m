From: luto@amacapital.net (Andy Lutomirski)
Date: Sat, 4 Feb 2017 19:46:45 -0800
Subject: [PATCH v3 2/2] nvme: Enable autonomous power state transitions
In-Reply-To: <348b90a06980a671ff82a6555cabbb292f46c837.1486158145.git.luto@kernel.org>
References: <cover.1486158145.git.luto@kernel.org>
 <348b90a06980a671ff82a6555cabbb292f46c837.1486158145.git.luto@kernel.org>
Message-ID: <CALCETrW8dixddw-y4pitqOqUJbJn9BieYkb4fg90iYrsTh5Gcw@mail.gmail.com>

On Fri, Feb 3, 2017@1:44 PM, Andy Lutomirski <luto@kernel.org> wrote:
> I currently have the specific bus drivers (pci and rdma) calling
> nvme_configure_apst() directly so that APST is only enabled after
> all IO queues are set up.  This way, if a device were to have a bug
> in which, say, admin queue reconfiguration while in an APST-induced
> idle state malfunctions, we won't trigger it.  I have no evidence
> that bugs like this exist in the wild, but, if they did and we
> enabled APST in nvme_init_identify(), we would only trigger them
> sporadically and they would be annoying to track down.

James Smart pointed out that I missed FC.  In my defense, I wrote this
code before FC showed up :-/

The only decent argument I have for not just putting
nvme_configure_apst() into nvme_init_identify() is the code in pci.c's
nvme_setup_io_queues() that tears down the admin queue interrupt and
the whole BAR mapping after nvme_init_identify().  This shouldn't be a
problem, but it makes me a tiny bit nervous to have APST on when we do
this -- is it plausible that something bad would happen if the NVMe
device took a nap while we this happens?

Christoph, Keith, and/or Jens, any insight here?  Maybe I should stop
worrying about this and just move everything into
nvme_init_identify().

--Andy
