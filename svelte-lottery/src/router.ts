
import PrizeConfig from './pages/PrizeConfig.svelte'
import PrizeTake from './pages/PrizeTake.svelte'

export default [
    {
        name: '/config',
        component: PrizeConfig,
    },
    {
        name: '/take',
        component: PrizeTake,
    },
    {
        redirectTo: '/config',
        name: '/',
    }
]
