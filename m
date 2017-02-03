From: lkp@intel.com (kbuild test robot)
Date: Sat, 4 Feb 2017 01:13:55 +0800
Subject: [PATCH 3/6] genirq/affinity: update CPU affinity for CPU hotplug
 events
In-Reply-To: <20170203143600.32307-4-hch@lst.de>
Message-ID: <201702040123.XdlQNmj5%fengguang.wu@intel.com>

Hi Christoph,

[auto build test ERROR on block/for-next]
[also build test ERROR on v4.10-rc6]
[cannot apply to next-20170203]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Christoph-Hellwig/genirq-allow-assigning-affinity-to-present-but-not-online-CPUs/20170203-224056
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: arm-socfpga_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from kernel/irq/internals.h:8:0,
                    from kernel/irq/affinity.c:9:
>> include/linux/irqdesc.h:52:25: error: field 'irq_common_data' has incomplete type
     struct irq_common_data irq_common_data;
                            ^~~~~~~~~~~~~~~
>> include/linux/irqdesc.h:53:19: error: field 'irq_data' has incomplete type
     struct irq_data  irq_data;
                      ^~~~~~~~
>> include/linux/irqdesc.h:55:2: error: unknown type name 'irq_flow_handler_t'
     irq_flow_handler_t handle_irq;
     ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/interrupt.h:5:0,
                    from kernel/irq/affinity.c:5:
   include/linux/irqdesc.h: In function 'irq_data_to_desc':
>> include/linux/irqdesc.h:111:26: error: dereferencing pointer to incomplete type 'struct irq_data'
     return container_of(data->common, struct irq_desc, irq_common_data);
                             ^
   include/linux/kernel.h:850:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^~~
   In file included from kernel/irq/internals.h:8:0,
                    from kernel/irq/affinity.c:9:
   include/linux/irqdesc.h: In function 'generic_handle_irq_desc':
>> include/linux/irqdesc.h:150:2: error: called object is not a function or function pointer
     desc->handle_irq(desc);
     ^~~~
   include/linux/irqdesc.h: At top level:
   include/linux/irqdesc.h:194:8: error: unknown type name 'irq_flow_handler_t'
           irq_flow_handler_t handler)
           ^~~~~~~~~~~~~~~~~~
   include/linux/irqdesc.h:215:6: error: unknown type name 'irq_flow_handler_t'
         irq_flow_handler_t handler, const char *name)
         ^~~~~~~~~~~~~~~~~~
   include/linux/irqdesc.h: In function 'irq_balancing_disabled':
>> include/linux/irqdesc.h:229:38: error: 'IRQ_NO_BALANCING_MASK' undeclared (first use in this function)
     return desc->status_use_accessors & IRQ_NO_BALANCING_MASK;
                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/irqdesc.h:229:38: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/irqdesc.h: In function 'irq_is_percpu':
>> include/linux/irqdesc.h:237:38: error: 'IRQ_PER_CPU' undeclared (first use in this function)
     return desc->status_use_accessors & IRQ_PER_CPU;
                                         ^~~~~~~~~~~
   In file included from kernel/irq/internals.h:62:0,
                    from kernel/irq/affinity.c:9:
   kernel/irq/debug.h: In function 'print_irq_desc':
>> kernel/irq/debug.h:16:28: warning: format '%p' expects argument of type 'void *', but argument 2 has type 'int' [-Wformat=]
     printk("->handle_irq():  %p, ", desc->handle_irq);
                               ^
>> kernel/irq/debug.h:26:7: error: 'IRQ_LEVEL' undeclared (first use in this function)
     ___P(IRQ_LEVEL);
          ^
   kernel/irq/debug.h:7:50: note: in definition of macro '___P'
    #define ___P(f) if (desc->status_use_accessors & f) printk("%14s set\n", #f)
                                                     ^
>> kernel/irq/debug.h:27:7: error: 'IRQ_PER_CPU' undeclared (first use in this function)
     ___P(IRQ_PER_CPU);
          ^
   kernel/irq/debug.h:7:50: note: in definition of macro '___P'
    #define ___P(f) if (desc->status_use_accessors & f) printk("%14s set\n", #f)
                                                     ^
>> kernel/irq/debug.h:28:7: error: 'IRQ_NOPROBE' undeclared (first use in this function)
     ___P(IRQ_NOPROBE);
          ^
   kernel/irq/debug.h:7:50: note: in definition of macro '___P'
    #define ___P(f) if (desc->status_use_accessors & f) printk("%14s set\n", #f)
                                                     ^
>> kernel/irq/debug.h:29:7: error: 'IRQ_NOREQUEST' undeclared (first use in this function)
     ___P(IRQ_NOREQUEST);
          ^
   kernel/irq/debug.h:7:50: note: in definition of macro '___P'
    #define ___P(f) if (desc->status_use_accessors & f) printk("%14s set\n", #f)
                                                     ^
>> kernel/irq/debug.h:30:7: error: 'IRQ_NOTHREAD' undeclared (first use in this function)
     ___P(IRQ_NOTHREAD);
          ^
   kernel/irq/debug.h:7:50: note: in definition of macro '___P'
    #define ___P(f) if (desc->status_use_accessors & f) printk("%14s set\n", #f)
                                                     ^
>> kernel/irq/debug.h:31:7: error: 'IRQ_NOAUTOEN' undeclared (first use in this function)
     ___P(IRQ_NOAUTOEN);
          ^
   kernel/irq/debug.h:7:50: note: in definition of macro '___P'
    #define ___P(f) if (desc->status_use_accessors & f) printk("%14s set\n", #f)
                                                     ^
   In file included from kernel/irq/internals.h:63:0,
                    from kernel/irq/affinity.c:9:
   kernel/irq/settings.h: At top level:
>> kernel/irq/settings.h:6:28: error: 'IRQ_DEFAULT_INIT_FLAGS' undeclared here (not in a function)
     _IRQ_DEFAULT_INIT_FLAGS = IRQ_DEFAULT_INIT_FLAGS,
                               ^~~~~~~~~~~~~~~~~~~~~~
>> kernel/irq/settings.h:7:18: error: 'IRQ_PER_CPU' undeclared here (not in a function)
     _IRQ_PER_CPU  = IRQ_PER_CPU,
                     ^~~~~~~~~~~
>> kernel/irq/settings.h:8:16: error: 'IRQ_LEVEL' undeclared here (not in a function)
     _IRQ_LEVEL  = IRQ_LEVEL,
                   ^~~~~~~~~
>> kernel/irq/settings.h:9:18: error: 'IRQ_NOPROBE' undeclared here (not in a function)
     _IRQ_NOPROBE  = IRQ_NOPROBE,
                     ^~~~~~~~~~~
>> kernel/irq/settings.h:10:20: error: 'IRQ_NOREQUEST' undeclared here (not in a function)
     _IRQ_NOREQUEST  = IRQ_NOREQUEST,
                       ^~~~~~~~~~~~~
>> kernel/irq/settings.h:11:19: error: 'IRQ_NOTHREAD' undeclared here (not in a function)
     _IRQ_NOTHREAD  = IRQ_NOTHREAD,
                      ^~~~~~~~~~~~

vim +/irq_data +53 include/linux/irqdesc.h

425a5072 Thomas Gleixner           2015-12-13   46   * @rcu:		rcu head for delayed free
ecb3f394 Craig Gallek              2016-09-13   47   * @kobj:		kobject used to represent this struct in sysfs
e144710b Thomas Gleixner           2010-10-01   48   * @dir:		/proc/irq/ procfs entry
e144710b Thomas Gleixner           2010-10-01   49   * @name:		flow handler name for /proc/interrupts output
e144710b Thomas Gleixner           2010-10-01   50   */
e144710b Thomas Gleixner           2010-10-01   51  struct irq_desc {
0d0b4c86 Jiang Liu                 2015-06-01  @52  	struct irq_common_data	irq_common_data;
e144710b Thomas Gleixner           2010-10-01  @53  	struct irq_data		irq_data;
6c9ae009 Eric Dumazet              2011-01-13   54  	unsigned int __percpu	*kstat_irqs;
e144710b Thomas Gleixner           2010-10-01  @55  	irq_flow_handler_t	handle_irq;
78129576 Thomas Gleixner           2011-02-10   56  #ifdef CONFIG_IRQ_PREFLOW_FASTEOI
78129576 Thomas Gleixner           2011-02-10   57  	irq_preflow_handler_t	preflow_handler;
78129576 Thomas Gleixner           2011-02-10   58  #endif
e144710b Thomas Gleixner           2010-10-01   59  	struct irqaction	*action;	/* IRQ action list */
a6967caf Thomas Gleixner           2011-02-10   60  	unsigned int		status_use_accessors;
dbec07ba Thomas Gleixner           2011-02-07   61  	unsigned int		core_internal_state__do_not_mess_with_it;
e144710b Thomas Gleixner           2010-10-01   62  	unsigned int		depth;		/* nested irq disables */
e144710b Thomas Gleixner           2010-10-01   63  	unsigned int		wake_depth;	/* nested wake enables */
e144710b Thomas Gleixner           2010-10-01   64  	unsigned int		irq_count;	/* For detecting broken IRQs */
e144710b Thomas Gleixner           2010-10-01   65  	unsigned long		last_unhandled;	/* Aging timer for unhandled count */
e144710b Thomas Gleixner           2010-10-01   66  	unsigned int		irqs_unhandled;
1e77d0a1 Thomas Gleixner           2013-03-07   67  	atomic_t		threads_handled;
1e77d0a1 Thomas Gleixner           2013-03-07   68  	int			threads_handled_last;
e144710b Thomas Gleixner           2010-10-01   69  	raw_spinlock_t		lock;
31d9d9b6 Marc Zyngier              2011-09-23   70  	struct cpumask		*percpu_enabled;
222df54f Marc Zyngier              2016-04-11   71  	const struct cpumask	*percpu_affinity;
e144710b Thomas Gleixner           2010-10-01   72  #ifdef CONFIG_SMP
e144710b Thomas Gleixner           2010-10-01   73  	const struct cpumask	*affinity_hint;
cd7eab44 Ben Hutchings             2011-01-19   74  	struct irq_affinity_notify *affinity_notify;
e144710b Thomas Gleixner           2010-10-01   75  #ifdef CONFIG_GENERIC_PENDING_IRQ
e144710b Thomas Gleixner           2010-10-01   76  	cpumask_var_t		pending_mask;
e144710b Thomas Gleixner           2010-10-01   77  #endif
e144710b Thomas Gleixner           2010-10-01   78  #endif
b5faba21 Thomas Gleixner           2011-02-23   79  	unsigned long		threads_oneshot;
e144710b Thomas Gleixner           2010-10-01   80  	atomic_t		threads_active;
e144710b Thomas Gleixner           2010-10-01   81  	wait_queue_head_t       wait_for_threads;
cab303be Thomas Gleixner           2014-08-28   82  #ifdef CONFIG_PM_SLEEP
cab303be Thomas Gleixner           2014-08-28   83  	unsigned int		nr_actions;
cab303be Thomas Gleixner           2014-08-28   84  	unsigned int		no_suspend_depth;
17f48034 Rafael J. Wysocki         2015-02-27   85  	unsigned int		cond_suspend_depth;
cab303be Thomas Gleixner           2014-08-28   86  	unsigned int		force_resume_depth;
cab303be Thomas Gleixner           2014-08-28   87  #endif
e144710b Thomas Gleixner           2010-10-01   88  #ifdef CONFIG_PROC_FS
e144710b Thomas Gleixner           2010-10-01   89  	struct proc_dir_entry	*dir;
e144710b Thomas Gleixner           2010-10-01   90  #endif
425a5072 Thomas Gleixner           2015-12-13   91  #ifdef CONFIG_SPARSE_IRQ
425a5072 Thomas Gleixner           2015-12-13   92  	struct rcu_head		rcu;
ecb3f394 Craig Gallek              2016-09-13   93  	struct kobject		kobj;
425a5072 Thomas Gleixner           2015-12-13   94  #endif
293a7a0a Thomas Gleixner           2012-10-16   95  	int			parent_irq;
b6873807 Sebastian Andrzej Siewior 2011-07-11   96  	struct module		*owner;
e144710b Thomas Gleixner           2010-10-01   97  	const char		*name;
e144710b Thomas Gleixner           2010-10-01   98  } ____cacheline_internodealigned_in_smp;
e144710b Thomas Gleixner           2010-10-01   99  
a8994181 Thomas Gleixner           2015-07-05  100  #ifdef CONFIG_SPARSE_IRQ
a8994181 Thomas Gleixner           2015-07-05  101  extern void irq_lock_sparse(void);
a8994181 Thomas Gleixner           2015-07-05  102  extern void irq_unlock_sparse(void);
a8994181 Thomas Gleixner           2015-07-05  103  #else
a8994181 Thomas Gleixner           2015-07-05  104  static inline void irq_lock_sparse(void) { }
a8994181 Thomas Gleixner           2015-07-05  105  static inline void irq_unlock_sparse(void) { }
e144710b Thomas Gleixner           2010-10-01  106  extern struct irq_desc irq_desc[NR_IRQS];
e144710b Thomas Gleixner           2010-10-01  107  #endif
e144710b Thomas Gleixner           2010-10-01  108  
7bbf1dd2 Jiang Liu                 2015-06-01  109  static inline struct irq_desc *irq_data_to_desc(struct irq_data *data)
7bbf1dd2 Jiang Liu                 2015-06-01  110  {
755d119a Thomas Gleixner           2015-09-16 @111  	return container_of(data->common, struct irq_desc, irq_common_data);
7bbf1dd2 Jiang Liu                 2015-06-01  112  }
7bbf1dd2 Jiang Liu                 2015-06-01  113  
304adf8a Jiang Liu                 2015-06-04  114  static inline unsigned int irq_desc_get_irq(struct irq_desc *desc)
304adf8a Jiang Liu                 2015-06-04  115  {
304adf8a Jiang Liu                 2015-06-04  116  	return desc->irq_data.irq;
304adf8a Jiang Liu                 2015-06-04  117  }
304adf8a Jiang Liu                 2015-06-04  118  
d9936bb3 Thomas Gleixner           2011-03-11  119  static inline struct irq_data *irq_desc_get_irq_data(struct irq_desc *desc)
d9936bb3 Thomas Gleixner           2011-03-11  120  {
d9936bb3 Thomas Gleixner           2011-03-11  121  	return &desc->irq_data;
d9936bb3 Thomas Gleixner           2011-03-11 @122  }
d9936bb3 Thomas Gleixner           2011-03-11  123  
a0cd9ca2 Thomas Gleixner           2011-02-10  124  static inline struct irq_chip *irq_desc_get_chip(struct irq_desc *desc)
a0cd9ca2 Thomas Gleixner           2011-02-10  125  {
a0cd9ca2 Thomas Gleixner           2011-02-10  126  	return desc->irq_data.chip;
a0cd9ca2 Thomas Gleixner           2011-02-10  127  }
a0cd9ca2 Thomas Gleixner           2011-02-10  128  
a0cd9ca2 Thomas Gleixner           2011-02-10  129  static inline void *irq_desc_get_chip_data(struct irq_desc *desc)
a0cd9ca2 Thomas Gleixner           2011-02-10  130  {
a0cd9ca2 Thomas Gleixner           2011-02-10  131  	return desc->irq_data.chip_data;
a0cd9ca2 Thomas Gleixner           2011-02-10  132  }
a0cd9ca2 Thomas Gleixner           2011-02-10  133  
a0cd9ca2 Thomas Gleixner           2011-02-10  134  static inline void *irq_desc_get_handler_data(struct irq_desc *desc)
a0cd9ca2 Thomas Gleixner           2011-02-10  135  {
af7080e0 Jiang Liu                 2015-06-01  136  	return desc->irq_common_data.handler_data;
a0cd9ca2 Thomas Gleixner           2011-02-10  137  }
a0cd9ca2 Thomas Gleixner           2011-02-10  138  
a0cd9ca2 Thomas Gleixner           2011-02-10  139  static inline struct msi_desc *irq_desc_get_msi_desc(struct irq_desc *desc)
a0cd9ca2 Thomas Gleixner           2011-02-10  140  {
b237721c Jiang Liu                 2015-06-01  141  	return desc->irq_common_data.msi_desc;
a0cd9ca2 Thomas Gleixner           2011-02-10  142  }
a0cd9ca2 Thomas Gleixner           2011-02-10  143  
e144710b Thomas Gleixner           2010-10-01  144  /*
e144710b Thomas Gleixner           2010-10-01  145   * Architectures call this to let the generic IRQ layer
6584d84c Huang Shijie              2015-09-01  146   * handle an interrupt.
e144710b Thomas Gleixner           2010-10-01  147   */
bd0b9ac4 Thomas Gleixner           2015-09-14  148  static inline void generic_handle_irq_desc(struct irq_desc *desc)
e144710b Thomas Gleixner           2010-10-01  149  {
bd0b9ac4 Thomas Gleixner           2015-09-14 @150  	desc->handle_irq(desc);
e144710b Thomas Gleixner           2010-10-01  151  }
e144710b Thomas Gleixner           2010-10-01  152  
fe12bc2c Thomas Gleixner           2011-05-18  153  int generic_handle_irq(unsigned int irq);
e144710b Thomas Gleixner           2010-10-01  154  
76ba59f8 Marc Zyngier              2014-08-26  155  #ifdef CONFIG_HANDLE_DOMAIN_IRQ
76ba59f8 Marc Zyngier              2014-08-26  156  /*
76ba59f8 Marc Zyngier              2014-08-26  157   * Convert a HW interrupt number to a logical one using a IRQ domain,
76ba59f8 Marc Zyngier              2014-08-26  158   * and handle the result interrupt number. Return -EINVAL if
76ba59f8 Marc Zyngier              2014-08-26  159   * conversion failed. Providing a NULL domain indicates that the
76ba59f8 Marc Zyngier              2014-08-26  160   * conversion has already been done.
76ba59f8 Marc Zyngier              2014-08-26  161   */
76ba59f8 Marc Zyngier              2014-08-26  162  int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
76ba59f8 Marc Zyngier              2014-08-26  163  			bool lookup, struct pt_regs *regs);
76ba59f8 Marc Zyngier              2014-08-26  164  
76ba59f8 Marc Zyngier              2014-08-26  165  static inline int handle_domain_irq(struct irq_domain *domain,
76ba59f8 Marc Zyngier              2014-08-26  166  				    unsigned int hwirq, struct pt_regs *regs)
76ba59f8 Marc Zyngier              2014-08-26  167  {
76ba59f8 Marc Zyngier              2014-08-26  168  	return __handle_domain_irq(domain, hwirq, true, regs);
76ba59f8 Marc Zyngier              2014-08-26  169  }
76ba59f8 Marc Zyngier              2014-08-26  170  #endif
76ba59f8 Marc Zyngier              2014-08-26  171  
e144710b Thomas Gleixner           2010-10-01  172  /* Test to see if a driver has successfully requested an irq */
f61ae4fb Thomas Gleixner           2015-08-02  173  static inline int irq_desc_has_action(struct irq_desc *desc)
e144710b Thomas Gleixner           2010-10-01  174  {
e144710b Thomas Gleixner           2010-10-01  175  	return desc->action != NULL;
e144710b Thomas Gleixner           2010-10-01  176  }
e144710b Thomas Gleixner           2010-10-01  177  
f61ae4fb Thomas Gleixner           2015-08-02  178  static inline int irq_has_action(unsigned int irq)
f61ae4fb Thomas Gleixner           2015-08-02  179  {
f61ae4fb Thomas Gleixner           2015-08-02  180  	return irq_desc_has_action(irq_to_desc(irq));
f61ae4fb Thomas Gleixner           2015-08-02  181  }
f61ae4fb Thomas Gleixner           2015-08-02  182  
bbc9d21f Thomas Gleixner           2015-06-23  183  /**
bbc9d21f Thomas Gleixner           2015-06-23  184   * irq_set_handler_locked - Set irq handler from a locked region
bbc9d21f Thomas Gleixner           2015-06-23  185   * @data:	Pointer to the irq_data structure which identifies the irq
bbc9d21f Thomas Gleixner           2015-06-23  186   * @handler:	Flow control handler function for this interrupt
bbc9d21f Thomas Gleixner           2015-06-23  187   *
bbc9d21f Thomas Gleixner           2015-06-23  188   * Sets the handler in the irq descriptor associated to @data.
bbc9d21f Thomas Gleixner           2015-06-23  189   *
bbc9d21f Thomas Gleixner           2015-06-23  190   * Must be called with irq_desc locked and valid parameters. Typical
bbc9d21f Thomas Gleixner           2015-06-23  191   * call site is the irq_set_type() callback.
bbc9d21f Thomas Gleixner           2015-06-23  192   */
bbc9d21f Thomas Gleixner           2015-06-23  193  static inline void irq_set_handler_locked(struct irq_data *data,
bbc9d21f Thomas Gleixner           2015-06-23 @194  					  irq_flow_handler_t handler)
bbc9d21f Thomas Gleixner           2015-06-23  195  {
bbc9d21f Thomas Gleixner           2015-06-23  196  	struct irq_desc *desc = irq_data_to_desc(data);
bbc9d21f Thomas Gleixner           2015-06-23  197  
bbc9d21f Thomas Gleixner           2015-06-23  198  	desc->handle_irq = handler;
bbc9d21f Thomas Gleixner           2015-06-23  199  }
bbc9d21f Thomas Gleixner           2015-06-23  200  
bbc9d21f Thomas Gleixner           2015-06-23  201  /**
bbc9d21f Thomas Gleixner           2015-06-23  202   * irq_set_chip_handler_name_locked - Set chip, handler and name from a locked region
bbc9d21f Thomas Gleixner           2015-06-23  203   * @data:	Pointer to the irq_data structure for which the chip is set
bbc9d21f Thomas Gleixner           2015-06-23  204   * @chip:	Pointer to the new irq chip
bbc9d21f Thomas Gleixner           2015-06-23  205   * @handler:	Flow control handler function for this interrupt
bbc9d21f Thomas Gleixner           2015-06-23  206   * @name:	Name of the interrupt
bbc9d21f Thomas Gleixner           2015-06-23  207   *
bbc9d21f Thomas Gleixner           2015-06-23  208   * Replace the irq chip at the proper hierarchy level in @data and
bbc9d21f Thomas Gleixner           2015-06-23  209   * sets the handler and name in the associated irq descriptor.
bbc9d21f Thomas Gleixner           2015-06-23  210   *
bbc9d21f Thomas Gleixner           2015-06-23  211   * Must be called with irq_desc locked and valid parameters.
bbc9d21f Thomas Gleixner           2015-06-23  212   */
bbc9d21f Thomas Gleixner           2015-06-23  213  static inline void
bbc9d21f Thomas Gleixner           2015-06-23  214  irq_set_chip_handler_name_locked(struct irq_data *data, struct irq_chip *chip,
bbc9d21f Thomas Gleixner           2015-06-23 @215  				 irq_flow_handler_t handler, const char *name)
bbc9d21f Thomas Gleixner           2015-06-23  216  {
bbc9d21f Thomas Gleixner           2015-06-23  217  	struct irq_desc *desc = irq_data_to_desc(data);
bbc9d21f Thomas Gleixner           2015-06-23  218  
bbc9d21f Thomas Gleixner           2015-06-23  219  	desc->handle_irq = handler;
bbc9d21f Thomas Gleixner           2015-06-23  220  	desc->name = name;
bbc9d21f Thomas Gleixner           2015-06-23  221  	data->chip = chip;
bbc9d21f Thomas Gleixner           2015-06-23  222  }
bbc9d21f Thomas Gleixner           2015-06-23  223  
a2e8461a Thomas Gleixner           2011-03-23  224  static inline int irq_balancing_disabled(unsigned int irq)
a2e8461a Thomas Gleixner           2011-03-23  225  {
e144710b Thomas Gleixner           2010-10-01  226  	struct irq_desc *desc;
e144710b Thomas Gleixner           2010-10-01  227  
e144710b Thomas Gleixner           2010-10-01  228  	desc = irq_to_desc(irq);
0c6f8a8b Thomas Gleixner           2011-03-28 @229  	return desc->status_use_accessors & IRQ_NO_BALANCING_MASK;
e144710b Thomas Gleixner           2010-10-01  230  }
78129576 Thomas Gleixner           2011-02-10  231  
7f4a8e7b Vinayak Kale              2013-12-04  232  static inline int irq_is_percpu(unsigned int irq)
7f4a8e7b Vinayak Kale              2013-12-04  233  {
7f4a8e7b Vinayak Kale              2013-12-04  234  	struct irq_desc *desc;
7f4a8e7b Vinayak Kale              2013-12-04  235  
7f4a8e7b Vinayak Kale              2013-12-04  236  	desc = irq_to_desc(irq);
7f4a8e7b Vinayak Kale              2013-12-04 @237  	return desc->status_use_accessors & IRQ_PER_CPU;
7f4a8e7b Vinayak Kale              2013-12-04  238  }
7f4a8e7b Vinayak Kale              2013-12-04  239  
d3e17deb Thomas Gleixner           2011-03-22  240  static inline void

:::::: The code at line 53 was first introduced by commit
:::::: e144710b302525de5b90b9c3ba43562458d8957f genirq: Distangle irq.h

:::::: TO: Thomas Gleixner <tglx at linutronix.de>
:::::: CC: Thomas Gleixner <tglx at linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 19463 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170204/56e8eb20/attachment-0001.gz>
