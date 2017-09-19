From: keith.busch@intel.com (Keith Busch)
Date: Tue, 19 Sep 2017 13:33:35 -0400
Subject: compile nvme 4.13 appear error
In-Reply-To: <CADL4p-pCuQmoEmRrwb0skct8OEJjGsTEkfhC4guV8Pgx6rWAew@mail.gmail.com>
References: <CADL4p-phBMqbqzR052xHBf_0=PPuGyvR82FoS=aaM_h7w_S7SA@mail.gmail.com>
 <20170918172734.GD17096@localhost.localdomain>
 <CADL4p-pPFxsi1B0gTKutUEAdiWpHCk99NR0E4ed6Y5_eYe=p0Q@mail.gmail.com>
 <20170919021019.GA5096@localhost.localdomain>
 <CADL4p-pCuQmoEmRrwb0skct8OEJjGsTEkfhC4guV8Pgx6rWAew@mail.gmail.com>
Message-ID: <20170919173335.GD6180@localhost.localdomain>

On Tue, Sep 19, 2017@11:27:39PM +0800, Tony Yang wrote:
> Hi,
> 
>  I Once again downloaded the nvme 4.13 in
> http://git.infradead.org/nvme.git, and then recompile the kernel, the
> error occurred, how can I solve it, I hope to get your help, thank you
> very much?
> 
>  CC [M]  drivers/nvme/host/core.o
> drivers/nvme/host/core.c: In function 'nvme_alloc_mpath_ns':
> drivers/nvme/host/core.c:3111:34: error: 'NVME_FAILOVER_RETRIES'
> undeclared (first use in this function)
>   if (nvme_set_ns_active(nsa, ns, NVME_FAILOVER_RETRIES)) {
>                                   ^
> drivers/nvme/host/core.c:3111:34: note: each undeclared identifier is
> reported only once for each function it appears in
> drivers/nvme/host/core.c: In function 'nvme_trigger_failover':
> drivers/nvme/host/core.c:3277:50: error: 'NVME_FAILOVER_RETRIES'
> undeclared (first use in this function)
>      if (nvme_set_ns_active(standby_ns, mpath_ns, NVME_FAILOVER_RETRIES)) {
>                                                   ^
> make[3]: *** [drivers/nvme/host/core.o] Error 1
> make[2]: *** [drivers/nvme/host] Error 2
> make[1]: *** [drivers/nvme] Error 2
> make: *** [drivers] Error 2

Like I said before, those errors do not exist in an unmodified version
of the git repo you're linking to. You've out-of-tree stuff in your
source, so you or whoever set it up broke it.
