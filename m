From: hare@suse.de (Hannes Reinecke)
Date: Tue, 8 May 2018 08:03:57 +0200
Subject: [PATCH 5/7] nvme_fc: change controllers first connect to use
 reconnect path
In-Reply-To: <20180508001214.8951-6-jsmart2021@gmail.com>
References: <20180508001214.8951-1-jsmart2021@gmail.com>
 <20180508001214.8951-6-jsmart2021@gmail.com>
Message-ID: <20180508080357.64c96380@pentland.suse.de>

On Mon,  7 May 2018 17:12:12 -0700
"James Smart" <jsmart2021@gmail.com> wrote:

> Current code follows the framework that has been in the transports
> from the beginning where initial link-side controller connect occurs
> as part of "creating the controller". Thus that first connect fully
> talks to the controller and obtains values that can then be used in
> for blk-mq setup, etc. It also means that everything about the
> controller is fully know before the "create controller" call returns.
> 
> This has several weaknesses:
> - The initial create_ctrl call made by the cli will block for a long
>   time as wire transactions are performed synchronously. This delay
>   becomes longer if errors occur or connectivity is lost and retries
>   need to be performed.
> - Code wise, it means there is a separate connect path for initial
>   controller connect vs the (same) steps used in the reconnect path.
> - And as there's separate paths, it means there's separate error
>   handling and retry logic. It also plays havoc with the NEW state
>   (should transition out of it after successful initial connect) vs
>   the RESETTING and CONNECTING (reconnect) states that want to be
>   transitioned to on error.
> - As there's separate paths, to recover from errors and disruptions,
>   it requires separate recovery/retry paths as well and can severely
>   convolute the controller state.
> - Given the duration of the initial create_ctrl() call, automation
>   of dynamic discovery can't use simplistic udev rules. Instead,
>   more convoluted use of systemd is required.
> 
> This patch reworks the fc transport to use the same connect paths
> for the initial connection as it uses for reconnect. This makes a
> single path for error recovery and handling. Given that the initial
> connect becomes asynchronous on a background work thread, the
> create_ctrl() now returns very quickly, allowing the simplified
> auto-connnect scripting.
> 
> This patch:
> - Removes the driving of the initial connect and replaces it with
>   a state transition to CONNECTING and initiating the reconnect
>   thread. A dummy state transition of RESETTING had to be traversed
>   as a direct transtion of NEW->CONNECTING is not allowed. Given
>   that the controller is "new", the RESETTING transition is a simple
>   no-op. Once in the reconnecting thread, the normal behaviors of
>   ctrl_loss_tmo (max_retries * connect_delay) and dev_loss_tmo will
>   apply before the controller is torn down.
> - Only if the state transitions couldn't be traversed and the
>   reconnect thread not scheduled, will the controller be torn down
>   while in create_ctrl.
> - The prior code used the controller state of NEW to indicate
>   whether request queues had been initialized or not. For the admin
>   queue, the request queue is always created, so there's no need to
>   check a state. For IO queues, change to tracking whether a
> successful io request queue create has occurred (e.g. 1st successful
> connect).
> - The initial controller id is initialized to the dynamic controller
>   id used in the initial connect message. It will be overwritten by
>   the real controller id once the controller is connected on the wire.
> 
> Note: this patch is dependent on these changes that have been
> added to the nvme-cli utility:
> - nvme-cli: Wait for device file if not present after successful
> add_ctrl
> - nvme-cli: Add ioctl retry support for "connect-all"
> 
> With this patch, a simplistic udev rule such as one of the following
> options below, may now be used to support auto connectivity:
> 
> option A:
>    ACTION=="change", SUBSYSTEM=="fc", ENV{FC_EVENT}=="nvmediscovery",
> \ ENV{NVMEFC_HOST_TRADDR}=="*", ENV{NVMEFC_TRADDR}=="*", \
> 	RUN+="/usr/sbin/nvme connect-all --transport=fc
> --host-traddr=$env{NVMEFC_HOST_TRADDR} --traddr=$env{NVMEFC_TRADDR}"
> 
> option B:
>    SUBSYSTEM!="fc", GOTO="nvme_autoconnect_end"
>    ACTION!="change", GOTO="nvme_autoconnect_end"
>    ENV{FC_EVENT}!="nvmediscovery", GOTO="nvme_autoconnect_end"
>    ENV{NVMEFC_HOST_TRADDR}!="?*", GOTO="nvme_autoconnect_end"
>    ENV{NVMEFC_TRADDR}!="?*", GOTO="nvme_autoconnect_end"
>    RUN+="/usr/sbin/nvme connect-all -t fc
> --host-traddr=$env{NVMEFC_HOST_TRADDR} -a $env{NVMEFC_TRADDR}"
> LABEL="nvme_autoconnect_end"
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/host/fc.c | 102
> ++++++++++++++++++++++--------------------------- 1 file changed, 45
> insertions(+), 57 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
