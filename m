From: winstonsmith@vfemail.net (Winston Smith)
Date: Wed, 02 Jan 2019 22:03:00 +0000
Subject: OWC Aura Pro X SSD
Message-ID: <3fe2c91b-d6b7-3f42-8af4-0620d7920a3d@vfemail.net>

hi all. i recently bought an NVME SSD for my aging macbook air and could
use a little help with it.

i dual-boot arch linux and macos on my laptop, but spend 99.99% of my
time in linux. i only keep macos around for firmware updates...useless os.

anyhow, since installing the new nvme ssd i am getting some pretty bad
battery life. i run tlp configure my laptop's power savings, and use
powertop to analyze power usage.

lspci shows that the Aura SSD uses a controller by Silicon Motion, the
'Silicon Motion, Inc. Device 2260'

powertop shows my pci and usb devices usage at 100%, but using 0 mW, is
that indicative of an issue?

i decided to try and look at my ssd directly, and here i get to the meat
of my question for this mailing list. i read about the power saving
kernel patch on the arch wiki:

https://wiki.archlinux.org/index.php/Solid_state_drive/NVMe#NVME_Power_Saving_Patch

when i run "nvme get-feature -f 0x0c -H /dev/nvme0" i get an error:

"NVMe Status:INVALID_FIELD"

i ran "nvme id-ctrl /dev/nvme0", here is the output:

> NVME Identify Controller:
> vid       : 0x126f
> ssvid     : 0x126f
> sn        : OW18112010047103E   
> mn        : OWC Aura Pro X SSD                      
> fr        : C2.3.23A
> rab       : 6
> ieee      : 000000
> cmic      : 0
> mdts      : 5
> cntlid    : 1
> ver       : 10200
> rtd3r     : 186a0
> rtd3e     : 13880
> oaes      : 0
> ctratt    : 0
> rrls      : 0
> oacs      : 0x16
> acl       : 4
> aerl      : 4
> frmw      : 0x12
> lpa       : 0x3
> elpe      : 63
> npss      : 4
> avscc     : 0x1
> apsta     : 0
> wctemp    : 335
> cctemp    : 345
> mtfa      : 50
> hmpre     : 0
> hmmin     : 0
> tnvmcap   : 0
> unvmcap   : 0
> rpmbs     : 0
> edstt     : 5
> dsto      : 1
> fwug      : 0
> kas       : 0
> hctma     : 0
> mntmt     : 0
> mxtmt     : 0
> sanicap   : 0
> hmminds   : 0
> hmmaxd    : 0
> nsetidmax : 0
> sqes      : 0x66
> cqes      : 0x44
> maxcmd    : 0
> nn        : 1
> oncs      : 0x1c
> fuses     : 0
> fna       : 0x1
> vwc       : 0x1
> awun      : 4
> awupf     : 0
> nvscc     : 1
> acwu      : 0
> sgls      : 0
> subnqn    : 
> ioccsz    : 0
> iorcsz    : 0
> icdoff    : 0
> ctrattr   : 0
> msdbd     : 0
> ps    0 : mp:9.00W operational enlat:5 exlat:5 rrt:0 rrl:0
>           rwt:0 rwl:0 idle_power:- active_power:-
> ps    1 : mp:4.60W operational enlat:30 exlat:30 rrt:1 rrl:1
>           rwt:1 rwl:1 idle_power:- active_power:-
> ps    2 : mp:3.80W operational enlat:30 exlat:30 rrt:2 rrl:2
>           rwt:2 rwl:2 idle_power:- active_power:-
> ps    3 : mp:0.0700W non-operational enlat:30000 exlat:10000 rrt:3 rrl:3
>           rwt:3 rwl:3 idle_power:- active_power:-
> ps    4 : mp:0.0050W non-operational enlat:50000 exlat:10000 rrt:4 rrl:4
>           rwt:4 rwl:4 idle_power:- active_power:-

is nvme power saving available with this (admittedly exotic) ssd? i see
the 'ps' fields in the id_ctrl output, but don't know what to do about
them. how can i find the correct feature number to use to check the
power saving status of my nvme drive?

thank you all in advance for any help you can provide.

winston smith

-------------------------------------------------

ONLY AT VFEmail! - Use our Metadata Mitigator to keep your email out of the NSA's hands!
$24.95 ONETIME Lifetime accounts with Privacy Features!  
15GB disk! No bandwidth quotas!
Commercial and Bulk Mail Options!  
